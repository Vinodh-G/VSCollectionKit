//
//  LoadingSectionHandler.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 16/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

class LoadingSectionHandler: SectionHandler {
    
    var sectionId: String
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: LoadingSkeletonCell.self),
                                 bundle: Bundle(for: LoadingSkeletonCell.self)),
                                forCellWithReuseIdentifier: LoadingSkeletonCell.loadingCellIdentifier)
        collectionView.register(LoadMoreCell.self,
                                forCellWithReuseIdentifier: LoadMoreCell.loadMoreCellIdentifier)
    }
    
    var sectionHeaderFooterProvider: VSCollectionKit.SectionHeaderFooterProvider?
    var sectionDelegateHandler: VSCollectionKit.SectionDelegateHandler?
    var parentViewController: VSCollectionKit.Weak<UIViewController>? = nil

    var viewModel: ConversationViewAPI?
    var type: String
    
    required init(sectionType: String, sectionId: String) {
        self.sectionId = sectionId
        self.type = sectionType
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellViewData: CellViewData) -> UICollectionViewCell {
        switch cellViewData.cellType {
        case MessageCellType.loadingskeleton.rawValue:
            guard let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingSkeletonCell.loadingCellIdentifier, for: indexPath) as? LoadingSkeletonCell else {
                return UICollectionViewCell()
            }
            loadingCell.startAnimating()
            return loadingCell
            
        case MessageCellType.loadMore.rawValue:
            guard let loadMoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreCell.loadMoreCellIdentifier, for: indexPath) as? LoadMoreCell else {
                return UICollectionViewCell()
            }
            loadMoreCell.startAnimating()
            return loadMoreCell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func sectionLayoutProvider(_ sectionViewData: VSCollectionKit.SectionViewData, _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
            
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(230))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                            leading: 12,
                                                            bottom: 12,
                                                            trailing: 12)
            return section
    }
}
