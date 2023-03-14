//
//  PhotoSectionDelegate.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Swamy on 04/07/21.
//  Copyright © 2021 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit
import UIKit

class PhotoSectionDelegate: SectionDelegateHandler {
    
    weak private var parentViewController: UIViewController?
    private let transitionDelegate: CollectionViewTransitioningDelegate = CollectionViewTransitioningDelegate()
    private let transitionCordinator: TransitionCordinator = TransitionCordinator()
    
    init(parentViewController: UIViewController?) {
        self.parentViewController = parentViewController
    }
    
    func didSelect(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cellModel: CellViewData) {
        
        guard let cellViewData = cellModel as? PhotoCellModel else { return }
        let collectionData = cellViewData.viewData.collectionViewData.value
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath as IndexPath)
        let attributesFrame = attributes?.frame
        let frameToOpenFrom = collectionView.convert(attributesFrame!, to:  collectionView.superview)
        transitionDelegate.openingFrame = frameToOpenFrom
        
        let viewModel = ImageCollectionViewModel(collectionData: collectionData,
                                                 selectedIndex: indexPath.item)
        let imageCollectionController = ImageCollectionViewController(viewModel: viewModel)
        
        imageCollectionController.modalPresentationStyle = UIModalPresentationStyle.custom
        imageCollectionController.transitioningDelegate = transitionDelegate
        parentViewController?.navigationController?.present(imageCollectionController,
                                                               animated: true,
                                                               completion: nil)
    }
    
    func willDisplayCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cell: UICollectionViewCell, _ cellModel: CellViewData) {
        
    }
}
