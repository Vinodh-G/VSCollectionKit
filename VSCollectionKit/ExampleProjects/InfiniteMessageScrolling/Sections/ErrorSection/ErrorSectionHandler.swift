//
//  ErrorSectionHandler.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 23/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

class ErrorSectionHandler: SectionHandler {
    
    required init(sectionType: String, sectionId: String) {
        self.sectionId = sectionId
        self.type = sectionType
    }
    
    var sectionId: String
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: ErrorCell.self),
                                      bundle: Bundle(for: ErrorCell.self)),
                                forCellWithReuseIdentifier: ErrorCell.errorCellIdentifier)
    }
    
    var sectionHeaderFooterProvider: VSCollectionKit.SectionHeaderFooterProvider? = nil
    var sectionDelegateHandler: VSCollectionKit.SectionDelegateHandler? = nil
    var parentViewController: VSCollectionKit.Weak<UIViewController>? = nil

    func sectionLayoutProvider(_ sectionViewData: VSCollectionKit.SectionViewData, _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                             subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12,
                                                            leading: 12,
                                                            bottom: 12,
                                                            trailing: 12)
            return section
    }
    

    var type: String
    var viewModel: ConversationViewRetryAction?


    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellViewData: CellViewData) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCell.errorCellIdentifier, for: indexPath) as? ErrorCell,
              let errorCellModel = cellViewData as? ErrorCellModel else { return UICollectionViewCell() }
        cell.cellModel = errorCellModel
        cell.errorActionDelegate = self
        return cell
    }
    
    func registerCells(for tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: ErrorCell.self),
                                 bundle: Bundle(for: ErrorCell.self)),
                           forCellReuseIdentifier: ErrorCell.errorCellIdentifier)
    }
}

extension ErrorSectionHandler: ErrorActionDelegate {
    func didTapOn(cell: ErrorCell, errorAction: String) {
        viewModel?.retry()
    }
}
