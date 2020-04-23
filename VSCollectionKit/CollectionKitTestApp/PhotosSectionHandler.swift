//
//  PhotosSectionHandler.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

class PhotosSectionHandler: SectionHandler {
    var type: String {
        return AlbumSectionType.photos.rawValue
    }

    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(PhotoTumbnailCell.self, forCellWithReuseIdentifier: PhotoTumbnailCell.resuseId)
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoTumbnailCell.resuseId,
                                                            for: indexPath) as? PhotoTumbnailCell,
            let photoCellModel = cellModel as? PhotoCellModel else {
                                                                return UICollectionViewCell()
        }

        cell.cellModel = photoCellModel
        return cell
    }

    func sectionLayoutProvider(_ sectionModel: SectionModel,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.25))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [itemLayout])
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        return sectionLayout
    }
}
