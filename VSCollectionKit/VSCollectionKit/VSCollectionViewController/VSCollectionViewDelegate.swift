//
//  VNCollectionViewDelegate.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public class VSCollectionViewDelegate: NSObject, UICollectionViewDelegate {

    unowned private var collectionView: UICollectionView
    public var data: VSCollectionViewData?
    unowned private var sectionHandler: VSCollectionViewSectionHandller

    public init(collectionView: UICollectionView,
         sectionHandler: VSCollectionViewSectionHandller) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
        super.init()
        collectionView.delegate = self

        // TODO: Have to remove this
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: "section-header-element-kind",
                                withReuseIdentifier: "EmptyView")
        sectionHandler.registerCells(for:  collectionView)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        guard let collectionData = data else { return }
        sectionHandler.willDisplayCell(collectionView: collectionView,
                                       indexPath: indexPath,
                                       cell: cell,
                                       sectionModel: collectionData.sections[indexPath.section])
    }

    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        guard let collectionData = data else { return }
        sectionHandler.didSelectItemAt(collectionView,
                                       indexPath: indexPath,
                                       sectionModel: collectionData.sections[indexPath.section])
    }
}
