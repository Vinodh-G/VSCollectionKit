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
    let sectionHandler = VSCollectionViewSectionHandller()

    override func setUp() {

        let collectionLayout = UICollectionViewCompositionalLayout { section, environment in
            
            return self.sectionHandler.collectionLayout(for: self.mockCollectionViewData(),
                                                        section: section,
                                                        environment: environment)
            
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        sectionHandler.registerSectionHandlers(types: [MockSectionType.mockSection1.rawValue: MockSectionHandler.self],
                                               collectionView: collectionView)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCollectionLayoutInfo() {
        let layoutProvider = VSCollectionViewLayoutProvider(collectionView: collectionView,
                                                            sectionHandler: sectionHandler)
        layoutProvider.data = mockCollectionViewData()
        let layOutInfo = layoutProvider.collectionLayout(for: 0,
                                                         collectionViewData: mockCollectionViewData(),
                                                         environment: MockLayoutEnvironment())
        XCTAssertNotNil(layOutInfo)
    }
}
