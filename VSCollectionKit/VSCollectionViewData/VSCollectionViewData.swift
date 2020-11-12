//
//  VNCollectionViewData.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionModel {
    var sectionType: String { get }
    var sectionID: String { get }
    var header: HeaderViewModel? { get }
    var items: [CellModel] { get set }
}

public protocol HeaderViewModel {
    var headerType: String { get }
}

public protocol CellModel {
    var cellType: String { get }
    var cellID: String { get }
}

public struct VSCollectionViewData {
    public var sections: [SectionModel] = []
    private var updates: [VSCollectionViewUpdate.Update] = []
    public var update: VSCollectionViewUpdate {
        return VSCollectionViewUpdate(updates: updates)
    }

    public init() {}

    public mutating func resetUpdate() {
        updates.removeAll()
    }

    mutating public func insert(section: SectionModel, at sectionIndex: Int) {
        sections.insert(section, at: sectionIndex)
        let update = VSCollectionViewUpdate.Update(type: .insert,
                                              sections: IndexSet(integer: sectionIndex), rows: nil)
        updates.append(update)
    }

    mutating public func add(section: SectionModel) {
        let update = VSCollectionViewUpdate.Update(type: .insert,
                                              sections: IndexSet(integer: sections.count), rows: nil)
        updates.append(update)
        sections.append(section)
    }

    mutating public func add(items: [CellModel], to section: SectionModel) {
        guard let sectionIndex = sections.firstIndex(where: { $0.sectionType == section.sectionType &&
            $0.sectionID == section.sectionID
        })
            else { return }

        var newSection = section
        newSection.items.append(contentsOf: items)
        sections[sectionIndex] = newSection

        var indexPaths: [DataIndexPath] = []
        for index in section.items.count..<(newSection.items.count) {
            let newPath = DataIndexPath(item: index, section: sectionIndex)
            indexPaths.append(newPath)
        }

        let update = VSCollectionViewUpdate.Update(type: .insert,
                                              sections: nil,
                                              rows: indexPaths)

        updates.append(update)
    }

    public func sectionModel(for type: String) -> SectionModel? {
        guard let sectionIndex = sections.firstIndex(where: { $0.sectionType == type }) else { return nil }
        return sections[sectionIndex]
    }

    public mutating func delete(section: SectionModel) {
        guard let sectionIndex = sections.firstIndex(where:
            { $0.sectionType == section.sectionType && $0.sectionID == section.sectionID }) else { return }
        sections.remove(at: sectionIndex)
        let update = VSCollectionViewUpdate.Update(type: .delete,
                                              sections: IndexSet(integer: sectionIndex),
                                              rows: nil)
        updates.append(update)
    }

    public mutating func update(newSection: SectionModel) {
        guard let sectionIndex = sections.firstIndex(where:
            { $0.sectionType == newSection.sectionType &&
                $0.sectionID == newSection.sectionID }) else { return }
        sections[sectionIndex] = newSection

        let update = VSCollectionViewUpdate.Update(type: .reload,
                                              sections: IndexSet(integer: sectionIndex),
                                              rows: nil)
        updates.append(update)
    }

    public mutating func update(item: CellModel, indexPath: DataIndexPath) {

        guard sections.count > indexPath.section,
            sections[indexPath.section].items.count > indexPath.item else { return }

        var sectionModel = sections[indexPath.section]
        sectionModel.items.remove(at: indexPath.item)
        sectionModel.items.insert(item, at: indexPath.item)

        let update = VSCollectionViewUpdate.Update(type: .insert,
                                                   sections: nil,
                                                   rows: [indexPath])
        updates.append(update)
    }

    public mutating func deleteItem(at indexPath: DataIndexPath) {

        guard sections.count > indexPath.section,
            sections[indexPath.section].items.count > indexPath.item else { return }
        
        var newSection = sections[indexPath.section]
        newSection.items.remove(at: indexPath.item)
        sections[indexPath.section] = newSection

        let update = VSCollectionViewUpdate.Update(type: .delete,
                                              sections: nil,
                                              rows: [indexPath])
        updates.append(update)
    }
}

public struct DataIndexPath: Equatable {
    
    public let item: Int
    public let section: Int
    /// Initialize for use with `VSCollectionData`.
    public init(item: Int, section: Int) {
        self.item = item
        self.section = section
    }
}
