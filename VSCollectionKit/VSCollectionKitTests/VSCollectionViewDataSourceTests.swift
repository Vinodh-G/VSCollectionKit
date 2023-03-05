//
//  VSCollectionViewDataSourceTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import XCTest
import UIKit
@testable import VSCollectionKit

class VSCollectionViewDataSourceTests: XCTestCase {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let sectionHandler = VSCollectionViewSectionHandller()
    override func setUp() {
        sectionHandler.registerSectionHandlers(types: [MockSectionType.mockSection1.rawValue: MockSectionHandler.self],
                                               collectionView: collectionView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialNumberOfSections() {
        let dataSource = vsDataSource()
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 0)
    }

    func testNumberOfSections() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data)
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 2)
    }

    func testNumberOfItemsForSection() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data)
        XCTAssertEqual(dataSource.collectionView(collectionView,
                                                 numberOfItemsInSection: 1), 20)
        XCTAssertEqual(dataSource.collectionView(collectionView,
                                                 numberOfItemsInSection: 0), 20)
    }

    func testCellForIndexPath() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data)
        let cell = dataSource.collectionView(collectionView,
                                             cellForItemAt: IndexPath(item: 3, section: 1))
        XCTAssert(cell.isKind(of: MockCollectionViewCell.self))
    }

    func testHeaderViewForSection() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data)
        let headerView = dataSource.collectionView(collectionView,
                                                   viewForSupplementaryElementOfKind: "section-header-element-kind",
                                                   at: IndexPath(item: 3, section: 1))
        XCTAssertNotNil(headerView)
        XCTAssert(headerView.isKind(of: MockHeaderView.self))
    }
    
    private func vsDataSource() -> VSCollectionViewDataSource {
        let dataSource = VSCollectionViewDataSource(collectionView: collectionView,
                                                    sectionHandler: sectionHandler)

        return dataSource
    }
}

extension XCTestCase {
    func mockCollectionViewData() -> VSCollectionViewData {
        var mockData = VSCollectionViewData()
        
        var mockSectionModel1 = MockSectionModel(sectionType: MockSectionType.mockSection1.rawValue,
                                                 sectionName: "Section One",
                                                 sectionId: "Section One")
        let headerVierModel = MockSectionHeader(headerType: MockSectionType.mockSection1.rawValue)
        mockSectionModel1.header = headerVierModel
        
        let mockSectionModel2 = MockSectionModel(sectionType: MockSectionType.mockSection1.rawValue,
                                                 sectionName: "Section Two",
                                                 sectionId: "Section Two")
        let sectionOneSnapshot = SectionSnapshot(viewData: mockSectionModel1)
        let sectionTwoSnapshot = SectionSnapshot(viewData: mockSectionModel2)

        mockData.appendSections([sectionOneSnapshot, sectionTwoSnapshot])
        mockData.appendItems(mockSectionModel1.cellItems.map { CellSnapshot(cellModel: $0) }, toSection: sectionOneSnapshot)
        mockData.appendItems(mockSectionModel2.cellItems.map { CellSnapshot(cellModel: $0) },  toSection: sectionTwoSnapshot)
        
        return mockData
    }
}
