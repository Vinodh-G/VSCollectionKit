//
//  VSCollectionViewSectionHandlerTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 17/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import XCTest
import UIKit
@testable import VSCollectionKit

class VSCollectionViewSectionHandlerTests: XCTestCase {

    var collectionView: UICollectionView!
    let mockSectionHandler = MockSectionHandler(sectionType: MockSectionType.mockSection1.rawValue,
                                                sectionId: "123214")
    let sectionHandler = VSCollectionViewSectionHandller()

    override func setUp() {
        let collectionViewLayout = UICollectionViewCompositionalLayout { (section, enivronment) -> NSCollectionLayoutSection? in
            return self.mockSectionHandler.sectionLayoutProvider(MockSectionModel(sectionType: "MockSection",
                                                                                  sectionName: "Mock Seciton Name", sectionId: "Mock Seciton Name"),
                                                                 MockLayoutEnvironment())
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        sectionHandler.registerSectionHandlers(types: [MockSectionType.mockSection1.rawValue: MockSectionHandler.self],
                                               collectionView: collectionView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberRows() {
        let sectionHandler = vsSectionHandler()
        let collectionViewData = mockCollectionViewData()
        var numOfRows = sectionHandler.numOfRows(for: collectionViewData,
                                                 sectionIndex: 0)
        let sectionSnapShot1 = collectionViewData.sectionIdentifiers[0]
        XCTAssertEqual(numOfRows, collectionViewData.itemIdentifiers(inSection: sectionSnapShot1).count)
        
        numOfRows = sectionHandler.numOfRows(for: collectionViewData,
                                                 sectionIndex: 1)
        let sectionSnapShot2 = collectionViewData.sectionIdentifiers[1]
        XCTAssertEqual(numOfRows, collectionViewData.itemIdentifiers(inSection: sectionSnapShot2).count)
    }

    func testCellForIndexPath() {

        let collectionViewData = mockCollectionViewData()

        let cell = sectionHandler.cell(for: collectionView,
                                       indexPath: IndexPath(item: 0,
                                                            section: 0),
                                       collectionViewData: collectionViewData)
        XCTAssertNotNil(cell)
        XCTAssert(cell.isKind(of: MockCollectionViewCell.self))
    }
    
    func testSupplementaryViewForIndexPath() {

        let collectionViewData = mockCollectionViewData()
        (collectionView.dataSource as? UICollectionViewDiffableDataSource)?.apply(collectionViewData)
        let headerView = sectionHandler.supplementaryView(collectionView: collectionView,
                                                          kind: "section-header-element-kind",
                                                          indexPath: IndexPath(item: 0, section: 0),
                                                          collectionViewData: collectionViewData)
        XCTAssertNotNil(headerView)
        XCTAssert(headerView!.isKind(of: MockHeaderView.self))
    }
    
    func testSectionLayoutInfo() {
        let collectionViewData = mockCollectionViewData()
        
        let layoutInfo = sectionHandler.collectionLayout(for: collectionViewData,
                                                         section: 0,
                                                         environment: MockLayoutEnvironment())
        XCTAssertNotNil(layoutInfo)
    }

    func testDelegateHandlerVerifyDidSelectCell() {
        let collectionData = mockCollectionViewData()
        let indexPath = IndexPath(item: 0,
                                  section: 0)
        _ = sectionHandler.cell(for: collectionView,
                                indexPath: indexPath,
                                collectionViewData: collectionData)

        let expectation = XCTestExpectation(description: "Expect Did Select Cell")
        
        let mockSectionHandler = sectionHandler.sectionHandlers["Section One"]
        mockSectionHandler?.sectionDelegateHandler = MockDelegateHandler(didSelectBlock: {  (collectionView, selectedIndexPath, cellModel) in
            XCTAssertEqual(indexPath, selectedIndexPath)
            expectation.fulfill()
        })
        
        sectionHandler.didSelectItemAt(collectionView,
                                       indexPath: indexPath,
                                       collectionViewData: collectionData)

        wait(for: [expectation], timeout: 1)
    }

    func testDelegateHandlerVerifyWillDisplayCell() {
        let collectionData = mockCollectionViewData()
        let indexPath = IndexPath(item: 0,
                                  section: 0)
        _ = sectionHandler.cell(for: collectionView,
                                indexPath: indexPath,
                                collectionViewData: collectionData)

        let expectation = XCTestExpectation(description: "Expect Will Display")
        
        let mockSectionHandler = sectionHandler.sectionHandlers["Section One"]
        mockSectionHandler?.sectionDelegateHandler = MockDelegateHandler(willDisplayBlock: { (collectionView, indexPath, cell, cellModel) in
            expectation.fulfill()
        })
        
        sectionHandler.willDisplayCell(collectionView: collectionView,
                                       indexPath: indexPath,
                                       cell: UICollectionViewCell(),
                                       collectionViewData: collectionData)

        wait(for: [expectation], timeout: 1)
    }
    
    func vsSectionHandler() -> VSCollectionViewSectionHandller {
        let sectionHandler = VSCollectionViewSectionHandller()
        return sectionHandler
    }
}
