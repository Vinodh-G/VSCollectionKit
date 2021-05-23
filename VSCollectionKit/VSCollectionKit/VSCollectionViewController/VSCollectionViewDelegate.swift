//
//  VNCollectionViewDelegate.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewDelegateAPI: UICollectionViewDelegate {
    var data: VSCollectionViewData? { get set }
}

public class VSCollectionViewDelegate: NSObject, VSCollectionViewDelegateAPI {

    unowned private var collectionView: UICollectionView
    public var data: VSCollectionViewData?
    unowned private var sectionHandler: VSCollectionViewSectionDelegateHandlerAPI

    public init(collectionView: UICollectionView,
         sectionHandler: VSCollectionViewSectionDelegateHandlerAPI) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
        super.init()
        collectionView.delegate = self
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        guard let collectionData = data else { return }
        let sectionModel = collectionData.sectionIdentifiers[indexPath.section].sectionModel
        sectionHandler.willDisplayCell(collectionView: collectionView,
                                       indexPath: indexPath,
                                       cell: cell,
                                       sectionModel: sectionModel)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        guard let collectionData = data else { return }
        let sectionModel = collectionData.sectionIdentifiers[indexPath.section].sectionModel
        sectionHandler.didSelectItemAt(collectionView,
                                       indexPath: indexPath,
                                       sectionModel: sectionModel)
    }
}
