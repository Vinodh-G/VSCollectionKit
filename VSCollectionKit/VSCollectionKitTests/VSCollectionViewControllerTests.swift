//
//  VSCollectionViewControllerTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Swamy on 22/11/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import XCTest
@testable import VSCollectionKit

class VSCollectionViewControllerTests: XCTestCase {

    func testSectionHandlerTypes() {
        let viewController = CollectionViewController()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.sectionHandlerTypes)
    }
    
    func testLayoutProvider() {
        let viewController = CollectionViewController()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.layoutProvider)
        XCTAssertTrue(viewController.layoutProvider is VSCollectionViewLayoutProvider)
    }
    
    func testDataProvider() {
        let viewController = CollectionViewController()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.dataProvider)
        XCTAssertTrue(viewController.dataProvider is VSCollectionViewDataSource)
    }
    
    func testDelegateHandler() {
        let viewController = CollectionViewController()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.delegateHandler)
        XCTAssertTrue(viewController.delegateHandler is VSCollectionViewDelegate)
    }
}

class CollectionViewController: VSCollectionViewController {
    override var sectionHandlerTypes: [String: SectionHandler.Type] {
        return [MockSectionType.mockSection1.rawValue: MockSectionHandler.self]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MockCollectionViewCell.self,
                                forCellWithReuseIdentifier: "CellId")
        dataProvider = MockCollectionViewDataSource(collectionView: collectionView,
                                                    sectionHandler: VSCollectionViewSectionHandller())
    }
}

class MockCollectionViewDataSource: VSCollectionViewDataSource {
    override func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}
