//
//  VSCollectionViewLayoutProviderTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 17/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import XCTest
import UIKit
@testable import VSCollectionKit

class VSCollectionViewLayoutProviderTests: XCTestCase {

    var collectionView: UICollectionView!

    override func setUp() {
        let collectionViewLayout = UICollectionViewCompositionalLayout { (section, enivronment) -> NSCollectionLayoutSection? in
            return self.mockSectionHandler.collectionLayout(for: MockSectionModel(sectionType: "MockSection",
            sectionName: "Mock Seciton Name"),
                                                            environment: MockLayoutEnvironment())
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let layoutProvider = VSCollectionViewLayoutProvider(collectionView: collectionView,
                                                            sectionHandler: mockSectionHandler)
        XCTAssertNotNil(layoutProvider.collectionLayout(for: MockSectionModel(sectionType: "MockSection", sectionName: "Mock Section Name"),
                                                        environment: MockLayoutEnvironment()))
    }

    var mockSectionHandler: VSCollectionViewSectionHandller {
        let sectionHand = VSCollectionViewSectionHandller()
        sectionHand.addSectionHandler(handler: MockSectionHandler())
        return sectionHand
    }

}
