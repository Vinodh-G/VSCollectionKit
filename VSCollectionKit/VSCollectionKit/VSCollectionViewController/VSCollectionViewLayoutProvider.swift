//
//  VNCollectionViewLayoutProvider.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewLayoutProviderAPI {
    var data: VSCollectionViewData { get set }
    func collectionLayout(for sectionIndex: Int,
                          collectionViewData: VSCollectionViewData,
                          environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

public class VSCollectionViewLayoutProvider: VSCollectionViewLayoutProviderAPI {

    unowned private var collectionView: UICollectionView
    unowned private var sectionHandler: VSCollectionViewSectionLayoutHandlerAPI
    public var data: VSCollectionViewData = VSCollectionViewData()

    public init(collectionView: UICollectionView,
                sectionHandler: VSCollectionViewSectionLayoutHandlerAPI) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
    }

    public func collectionLayout(for sectionIndex: Int,
                                 collectionViewData: VSCollectionViewData,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        
        return sectionHandler.collectionLayout(for: collectionViewData,
                                               section: sectionIndex,
                                               environment: environment)
    }
}
