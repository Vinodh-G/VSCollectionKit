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
        lhs.viewData.sectionId == rhs.viewData.sectionId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(viewData.sectionId)
    }
    
    public var viewData: SectionViewData
    
    public init(viewData: SectionViewData) {
        self.viewData = viewData
    }
}

public struct CellSnapshot: Hashable {
    var cellViewData: CellViewData
    
    public static func == (lhs: CellSnapshot, rhs: CellSnapshot) -> Bool {
        lhs.cellViewData.cellId == rhs.cellViewData.cellId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellViewData.cellId)
    }
    
    public init(cellModel: CellViewData) {
        self.cellViewData = cellModel
    }
}

public protocol SectionViewData {
    var sectionType: String { get }
    var sectionId: String { get }
    var header: SectionHeaderViewData? { get }
}

public protocol SectionHeaderViewData {
    var headerType: String { get }
}

public protocol CellViewData {
    var cellType: String { get }
    var cellId: String { get }
}
