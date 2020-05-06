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
        sectionHandler.addSectionHandler(handler: MockSectionHandler())
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
        dataSource.apply(data: data, animated: true)
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 2)
    }

    func testNumberOfItemsForSection() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data: data, animated: true)
        XCTAssertEqual(dataSource.collectionView(collectionView,
                                                 numberOfItemsInSection: 1), 20)
    }

    func testCellForIndexPath() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data: data, animated: true)
        let cell = dataSource.collectionView(collectionView,
                                             cellForItemAt: IndexPath(item: 3, section: 1))
        XCTAssert(cell.isKind(of: MockCollectionViewCell.self))
    }

    func testHeaderViewForSection() {
        let dataSource = vsDataSource()
        let data = mockCollectionViewData()
        dataSource.apply(data: data, animated: true)
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
        mockData.add(section: MockSectionModel(sectionType: "MockSection", sectionName: "Section One"))
        mockData.add(section: MockSectionModel(sectionType: "MockSection", sectionName: "Section Two"))
        return mockData
    }
}
