//
//  MockSectionModel.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit

struct MockSectionModel: SectionViewData {
    var sectionType: String
    var header: SectionHeaderViewData?
    var cellItems: [CellViewData] = []
    var sectionName: String
    var sectionId: String

    init(sectionType: String, sectionName: String, sectionId: String) {
        self.sectionType = sectionType
        self.sectionName = sectionName
        self.sectionId = sectionId
        self.header = MockSectionHeader(headerType: sectionType)

        for index in 0..<20 {
            cellItems.append(MockCellModel(cellType: "MockCell", cellInfo: "Cell \(index)"))
        }
    }
}

struct MockSectionHeader: SectionHeaderViewData {
    var headerType: String
}
