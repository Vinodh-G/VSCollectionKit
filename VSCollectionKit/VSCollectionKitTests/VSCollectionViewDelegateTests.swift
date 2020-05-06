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
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func vsDelegate() -> VSCollectionViewDelegate {
        let sectionHandler = VSCollectionViewSectionHandller()
        sectionHandler.addSectionHandler(handler: MockSectionHandler())
        let delegate = VSCollectionViewDelegate(collectionView: collectionView,
                                                sectionHandler: sectionHandler)
        return delegate
    }

}
