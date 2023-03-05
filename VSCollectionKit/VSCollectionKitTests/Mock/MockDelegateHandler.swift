//
//  MockDelegateHandler.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Swamy on 22/11/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

typealias DidSelectBlock = (_ collectionView: UICollectionView,
                            _ indexPath: IndexPath,
                            _ cellModel: CellViewData) -> Void

typealias WillDisplayBlock = ((_ collectionView: UICollectionView,
                              _ indexPath: IndexPath,
                              _ cell: UICollectionViewCell,
                              _ cellModel: CellViewData) -> Void)

class MockDelegateHandler: SectionDelegateHandler {
    
    var didSelectBlock: DidSelectBlock?
    var willDisplayBlock: WillDisplayBlock?
    init(willDisplayBlock: @escaping WillDisplayBlock) {
        self.willDisplayBlock = willDisplayBlock
    }
    
    init(didSelectBlock: @escaping DidSelectBlock) {
        self.didSelectBlock = didSelectBlock
    }
    
    func didSelect(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cellModel: CellViewData) {
        didSelectBlock?(collectionView,
                        indexPath,
                        cellModel)
    }
    
    func willDisplayCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cell: UICollectionViewCell, _ cellModel: CellViewData) {
        willDisplayBlock?(collectionView,
                         indexPath,
                         cell,
                         cellModel)
    }
}
