//
//  VNCollectionViewLayoutProvider.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionViewData

public class VSCollectionViewLayoutProvider {

    unowned private var collectionView: UICollectionView
    unowned private var sectionHandler: VSCollectionViewSectionHandller
    public var data: VSCollectionViewData?

    public init(collectionView: UICollectionView,
                sectionHandler: VSCollectionViewSectionHandller) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
    }

    public func collectionLayout(for sectionIndex: Int,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let sectionModel = data?.sections[sectionIndex] else { return nil }
        return sectionHandler.collectionLayout(for: sectionModel,
                                               environment: environment)
    }
}
