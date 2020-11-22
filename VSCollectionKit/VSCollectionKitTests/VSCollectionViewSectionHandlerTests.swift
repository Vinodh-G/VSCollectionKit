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
    let mockSectionHandler = MockSectionHandler()
    override func setUp() {
        let collectionViewLayout = UICollectionViewCompositionalLayout { (section, enivronment) -> NSCollectionLayoutSection? in
            return self.mockSectionHandler.sectionLayoutProvider(MockSectionModel(sectionType: "MockSection",
            sectionName: "Mock Seciton Name"), MockLayoutEnvironment())
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberRows() {
        let sectionHandler = vsSectionHandler()
        XCTAssertEqual(sectionHandler.numOfRows(for: MockSectionModel(sectionType: "MockSection",
        sectionName: "Mock Seciton Name"), sectionIndex: 0), 20)
    }

    func testCellType() {
        let sectionHandler = vsSectionHandler()
        let cell = sectionHandler.cell(for: collectionView,
                                       indexPath: IndexPath(item: 0,
                                                            section: 0),
                                       sectionModel: MockSectionModel(sectionType: "MockSection",
                                                                      sectionName: "Mock Seciton Name"))
        XCTAssertNotNil(cell)
        XCTAssert(cell.isKind(of: MockCollectionViewCell.self))
    }

    func testSectionLayoutInfo() {
        let sectionHandler = vsSectionHandler()
        let layoutInfo = sectionHandler.collectionLayout(for: MockSectionModel(sectionType: "MockSection",
                                                                               sectionName: "Mock Seciton Name"),
                                                         environment: MockLayoutEnvironment())
        XCTAssertNotNil(layoutInfo)
    }

    
    func testDelegateHandlerVerifyDidSelectCell() {
        
        let delegateHandler = MockDelegateHandler()
        let mockSectionHandler = MockSectionHandler(delegateHadler: delegateHandler)
        let sectionHandler = VSCollectionViewSectionHandller()
        sectionHandler.addSectionHandler(handler: mockSectionHandler)
        
        let expectation = XCTestExpectation(description: "Expect Did Select")
        
        delegateHandler.didSelectBlock = { (collectionView, indexPath, cellModel) in
            expectation.fulfill()
        }
        
        
        sectionHandler.didSelectItemAt(collectionView,
                                       indexPath: IndexPath(item: 0,
                                                            section: 0),
                                       sectionModel: MockSectionModel(sectionType: "MockSection",
                                                                      sectionName: "Mock Seciton Name"))
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDelegateHandlerVerifyWillDisplayCell() {
        
        let delegateHandler = MockDelegateHandler()
        let mockSectionHandler = MockSectionHandler(delegateHadler: delegateHandler)
        let sectionHandler = VSCollectionViewSectionHandller()
        sectionHandler.addSectionHandler(handler: mockSectionHandler)
        
        let expectation = XCTestExpectation(description: "Expect Did Select")
        
        delegateHandler.willDisplayBlock = { (collectionView, indexPath, sectionModel, cellModel) in
            expectation.fulfill()
        }
        
        sectionHandler.willDisplayCell(collectionView: collectionView,
                                       indexPath: IndexPath(item: 0,
                                                            section: 0),
                                       cell: UICollectionViewCell(),
                                       sectionModel: MockSectionModel(sectionType: "MockSection",
                                                                      sectionName: "Mock Seciton Name"))
        
        wait(for: [expectation], timeout: 1)
    }
    
    func vsSectionHandler() -> VSCollectionViewSectionHandller {
        let sectionHandler = VSCollectionViewSectionHandller()
        sectionHandler.addSectionHandler(handler: mockSectionHandler)
        sectionHandler.registerCells(for: collectionView)
        return sectionHandler
    }
}
