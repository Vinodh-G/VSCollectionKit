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
    
    private let photosSelection: PhotosSelectionAPI
    init(selectionHandler: PhotosSelectionAPI) {
        self.photosSelection = selectionHandler
    }
    
    func didSelect(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cellModel: CellViewData) {
        if photosSelection.canSelect {
            guard var selectedCellModel = cellModel as? PhotoCellModel else { return }
            selectedCellModel.isSelected = true
            photosSelection.select(cellModel: selectedCellModel)
        }
    }
    
    func willDisplayCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ cell: UICollectionViewCell, _ cellModel: CellViewData) {
        
    }
}
