//
//  VSCollectionViewData.swift
//  VSCollectionKit
//
//  Created by Vinodh Swamy on 22/03/21.
//  Copyright © 2021 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public typealias VSCollectionViewData = NSDiffableDataSourceSnapshot<SectionSnapshot, CellSnapshot>

public struct SectionSnapshot: Hashable {
    public static func == (lhs: SectionSnapshot, rhs: SectionSnapshot) -> Bool {
        lhs.sectionModel.sectionId == rhs.sectionModel.sectionId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sectionModel.sectionId)
    }
    
    public var sectionModel: SectionModel
    public var cellSnapshots: [CellSnapshot] = []
    
    public init(sectionModel: SectionModel) {
        self.sectionModel = sectionModel
        self.cellSnapshots = sectionModel.cellItems.map{ return CellSnapshot(cellModel: $0) }
    }
}

public struct CellSnapshot: Hashable {
    var cellModel: CellModel
    
    public static func == (lhs: CellSnapshot, rhs: CellSnapshot) -> Bool {
        lhs.cellModel.cellId == rhs.cellModel.cellId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellModel.cellId)
    }
    
    public init(cellModel: CellModel) {
        self.cellModel = cellModel
    }
}

public protocol SectionModel {
    var sectionType: String { get }
    var sectionId: String { get }
    var header: HeaderViewModel? { get }
    var cellItems: [CellModel] { get set }
}

public protocol HeaderViewModel {
    var headerType: String { get }
}

public protocol CellModel {
    var cellType: String { get }
    var cellId: String { get }
}
