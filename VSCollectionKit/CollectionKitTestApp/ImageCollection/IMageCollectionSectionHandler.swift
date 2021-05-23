//
//  IMageCollectionSectionHandler.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

enum ImageCollectionSection: String {
    case photos
}

enum ImageCollectionCell: String {
    case photos
}

class ImageCollectionSectionHandler: SectionHandler {

    private var transitionCordinator: TransitionCordinator
    init(transitionCordinator: TransitionCordinator) {
        self.transitionCordinator = transitionCordinator
        self.transitionCordinator.fromDelegate = self
    }

    var type: String {
        return ImageCollectionSection.photos.rawValue
    }

    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.resuseId)
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.resuseId,
                                                            for: indexPath) as? ImageCell,
            let photoCellModel = cellModel as? PhotoCellModel else {
                                                                return UICollectionViewCell()
        }

        cell.cellModel = photoCellModel
        return cell
    }

    func sectionLayoutProvider(_ sectionModel: SectionModel,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
}

extension ImageCollectionSectionHandler: ZoomAnimatorDelegate {

    var transactionImage: UIImage? {
        return selectedCell?.imageView.image
    }

    var sourceFrame: CGRect? {
        return selectedCell?.imageView.convert( selectedCell?.imageView.frame ?? .zero,
                                               to: parentController?.view)
    }

    var destinationFrame: CGRect? {
        return selectedCell?.imageView.convert( selectedCell?.imageView.frame ?? .zero,
                                               to: parentController?.view)
    }

    func willBeginTransaction() {
        selectedCell?.imageView.isHidden =  true
    }

    func didEndTransaction() {
        selectedCell?.imageView.isHidden =  false
    }
}
