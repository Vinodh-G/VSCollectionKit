//
//  MockCellModel.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
@testable import VSCollectionViewData

struct MockCellModel: CellModel {
    let cellType: String
    let info: String
    let cellID: String
    
    init(cellType: String, cellInfo: String) {
        self.cellType = cellType
        self.info = cellInfo
        cellID = ProcessInfo.processInfo.globallyUniqueString
    }
}
