//
//  VNCollectionViewLayoutProvider.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewLayoutProviderAPI {
    var data: VSCollectionViewData? { get set }
    func collectionLayout(for sectionIndex: Int,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

public class VSCollectionViewLayoutProvider: VSCollectionViewLayoutProviderAPI {

    unowned private var collectionView: UICollectionView
    unowned private var sectionHandler: VSCollectionViewSectionLayoutHandlerAPI
    public var data: VSCollectionViewData?

    public init(collectionView: UICollectionView,
                sectionHandler: VSCollectionViewSectionLayoutHandlerAPI) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
    }

    public func collectionLayout(for sectionIndex: Int,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let sectionModel = data?.sectionIdentifiers[sectionIndex].sectionModel else { return nil }
        return sectionHandler.collectionLayout(for: sectionModel,
                                               environment: environment)
    }
}
