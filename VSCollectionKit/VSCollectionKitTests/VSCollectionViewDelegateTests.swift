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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testDelegateHandlerVerifyDidSelectCell() {
        
        let delegateHandler = MockDelegateHandler()
        let collectionViewDelegate = vsDelegate(delegateHandler: delegateHandler)
        collectionViewDelegate.data = mockCollectionViewData()
        let expectation = XCTestExpectation(description: "Expect Did Select")
        
        delegateHandler.didSelectBlock = { (collectionView, indexPath, cellModel) in
            expectation.fulfill()
        }
        
        collectionViewDelegate.collectionView(collectionView,
                                              didSelectItemAt: IndexPath(item: 0,
                                                                         section: 0))
        wait(for: [expectation], timeout: 1)
    }
    
    func testDelegateHandlerVerifyWillDisplayCell() {
        
        let delegateHandler = MockDelegateHandler()
        let collectionViewDelegate = vsDelegate(delegateHandler: delegateHandler)
        collectionViewDelegate.data = mockCollectionViewData()
        let expectation = XCTestExpectation(description: "Expect Did Select")
        
        delegateHandler.willDisplayBlock = { (collectionView, indexPath, cell, cellModel) in
            expectation.fulfill()
        }
        
        collectionViewDelegate.collectionView(collectionView,
                                              willDisplay: UICollectionViewCell(),
                                              forItemAt: IndexPath(item: 0, section: 0))
        wait(for: [expectation], timeout: 1)
    }
    
    private func vsDelegate(delegateHandler: MockDelegateHandler) -> VSCollectionViewDelegate {
        let mockSectionHandler = MockSectionHandler(delegateHadler: delegateHandler)
        sectionHandler.addSectionHandler(handler: mockSectionHandler)
        let delegate = VSCollectionViewDelegate(collectionView: collectionView,
                                                sectionHandler: sectionHandler)
        return delegate
    }

}
