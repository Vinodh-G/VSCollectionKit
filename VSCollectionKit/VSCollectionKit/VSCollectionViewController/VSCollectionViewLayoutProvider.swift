//
//  VNCollectionViewLayoutProvider.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public class VSCollectionViewLayoutProvider {

    private var collectionView: UICollectionView
    private var sectionHandler: VSCollectionViewSectionHandller

    public init(collectionView: UICollectionView,
         sectionHandler: VSCollectionViewSectionHandller) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
    }

    public func collectionLayout(for sectionModel: SectionModel,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return sectionHandler.collectionLayout(for: sectionModel,
                                               environment: environment)
    }
}
