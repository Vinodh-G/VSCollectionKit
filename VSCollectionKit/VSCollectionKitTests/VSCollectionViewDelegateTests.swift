//
//  VSCollectionViewDelegateTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import XCTest
import UIKit
@testable import VSCollectionKit

class VSCollectionViewDelegateTests: XCTestCase {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let sectionHandler = VSCollectionViewSectionHandller()

    override func setUp() {
        sectionHandler.registerSectionHandlers(types: [MockSectionType.mockSection1.rawValue: MockSectionHandler.self],
                                               collectionView: collectionView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testDelegateHandlerVerifyDidSelectCell() {

        let collectionData = mockCollectionViewData()
        let indexPath = IndexPath(item: 0,
                                  section: 0)

        let collectionViewDelegate = VSCollectionViewDelegate(collectionView: collectionView,
                                                              sectionHandler: sectionHandler)
        collectionViewDelegate.data = collectionData
        
        let expectation = XCTestExpectation(description: "Expect Did Select Cell")

        let mockSectionHandler = sectionHandler(for: "Section One")
        // Validation: verify didSelectBlock is triggered when we call didSelectItemAt on VSCollectionViewDelegate
        mockSectionHandler?.sectionDelegateHandler = MockDelegateHandler(didSelectBlock: { (collectionView, selectedIndexPath, cellModel) in
            XCTAssertEqual(indexPath, selectedIndexPath)
            expectation.fulfill()
        })
        
        // API to Test
        collectionViewDelegate.collectionView(collectionView, didSelectItemAt: indexPath)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDelegateHandlerVerifyWillDisplayCell() {
        
        let collectionData = mockCollectionViewData()
        let indexPath = IndexPath(item: 0,
                                  section: 0)

        let collectionViewDelegate = VSCollectionViewDelegate(collectionView: collectionView,
                                                              sectionHandler: sectionHandler)
        collectionViewDelegate.data = collectionData
        
        let expectation = XCTestExpectation(description: "Expect Did Select Cell")

        let mockSectionHandler = sectionHandler(for: "Section One")
        // Validation: verify didSelectBlock is triggered when we call didSelectItemAt on VSCollectionViewDelegate
        mockSectionHandler?.sectionDelegateHandler = MockDelegateHandler(willDisplayBlock: { (collectionView, incomingIndexPath, cell, cellModel) in
            XCTAssertEqual(indexPath, incomingIndexPath)
            expectation.fulfill()
        })
        
        // API to Test
        collectionViewDelegate.collectionView(collectionView,
                                              willDisplay: UICollectionViewCell(),
                                              forItemAt: indexPath)
        
        wait(for: [expectation], timeout: 1)
    }

    private func sectionHandler(for sectionId: String) -> SectionHandler? {
        
        let collectionData = mockCollectionViewData()
        let indexPath = IndexPath(item: 0,
                                  section: 0)
        _ = sectionHandler.cell(for: collectionView,
                                indexPath: indexPath,
                                collectionViewData: collectionData)
        
        return sectionHandler.sectionHandlers[sectionId]
    }
}
