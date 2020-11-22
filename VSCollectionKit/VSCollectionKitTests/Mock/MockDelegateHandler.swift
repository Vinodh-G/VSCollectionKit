//
//  MockDelegateHandler.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Swamy on 22/11/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit
import VSCollectionViewData

typealias DidSelectBlock = (_ collectionView: UICollectionView,
                            _ indexPath: IndexPath,
                            _ cellModel: CellModel) -> Void

typealias WillDisplayBlock = (_ collectionView: UICollectionView,
                              _ indexPath: IndexPath, _ cell: UICollectionViewCell,
                              _ cellModel: CellModel) -> Void

class MockDelegateHandler: SectionDelegateHandler {
    
    var didSelectBlock: DidSelectBlock?
    var willDisplayBlock: WillDisplayBlock?
    
    func didSelect(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cellModel: CellModel) {
        didSelectBlock?(collectionView,
                        indexPath,
                        cellModel)
    }
    
    func willDisplayCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cell: UICollectionViewCell, _ cellModel: CellModel) {
        willDisplayBlock?(collectionView,
                         indexPath,
                         cell,
                         cellModel)
    }
}
