//
//  MockSectionModel.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

@testable import VSCollectionKit

struct MockSectionModel: SectionModel {
    var sectionType: String
    var header: HeaderViewModel?
    var items: [CellModel] = []
    var sectionName: String
    var sectionID: String

    init(sectionType: String, sectionName: String) {
        self.sectionType = sectionType
        self.sectionName = sectionName
        sectionID = UUID().uuidString
        header = MockSectionHeader(headerType: sectionType)

        for index in 0..<20 {
            items.append(MockCellModel(cellType: "MockCell", cellInfo: "Cell \(index)"))
        }
    }
}

struct MockSectionHeader: HeaderViewModel {
    var headerType: String
}
