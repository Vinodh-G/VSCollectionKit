//
//  MockCellModel.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
@testable import VSCollectionKit

struct MockCellModel: CellViewData {
    let cellType: String
    let info: String
    let cellId: String
    
    init(cellType: String, cellInfo: String, cellId: String = ProcessInfo.processInfo.globallyUniqueString) {
        self.cellType = cellType
        self.info = cellInfo
        self.cellId = cellId
    }
}
