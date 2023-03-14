//
//  MessageSectionHandler.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 15/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

class MessageSectionHandler: SectionHandler {
    
    var sectionId: String
    var sectionHeaderFooterProvider: VSCollectionKit.SectionHeaderFooterProvider?
    var sectionDelegateHandler: VSCollectionKit.SectionDelegateHandler?
    var parentViewController: VSCollectionKit.Weak<UIViewController>?
    let type: String
    var viewModel: ConversationViewDeleteAction?
    
    required init(sectionType: String, sectionId: String) {
        self.sectionId = sectionId
        self.type = sectionType
    }

    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(MessageCell.self,
                                forCellWithReuseIdentifier: MessageCell.messageCellIdentifier)
        collectionView.register(UINib(nibName: String(describing: MessageCell.self),
                                 bundle: Bundle(for: MessageCell.self)),
                                forCellWithReuseIdentifier: MessageCell.messageCellIdentifier)
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellViewData: CellViewData) -> UICollectionViewCell {
        guard let messageCellModel = cellViewData as? MessageCellModel,
              let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.messageCellIdentifier,
                                                            for: indexPath) as? MessageCell else {
            return UICollectionViewCell()
        }
        messageCell.cellModel = messageCellModel
        return messageCell
    }
    
    func sectionLayoutProvider(_ sectionViewData: VSCollectionKit.SectionViewData, _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(308))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1.0),
                                               heightDimension: .estimated(308))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        return layoutSection
    }
}

//extension MessageSectionHandler: SwipableAction {
//
//    func leadingSwipeAction(tableView: UITableView,
//                            indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let action = UIContextualAction(style: .destructive, title: "",
//          handler: { (action, view, completionHandler) in
//          // Update data source when user taps action
//            self.viewModel?.deleteMessage(at: indexPath)
//            completionHandler(true)
//        })
//        action.image = AppImage.trachIcon
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        return configuration
//    }
//
//    func trailingSwipeAction(tableView: UITableView,
//                             indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .destructive, title: "",
//          handler: { (action, view, completionHandler) in
//          // Update data source when user taps action
//            self.viewModel?.deleteMessage(at: indexPath)
//            completionHandler(true)
//        })
//        action.image = AppImage.trachIcon
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        return configuration
//    }
//}

//extension MessageSectionHandler: EditCellAction {
//
//    func canEditRow(_ tableView: UITableView,
//                    _ atIndexPath: IndexPath,
//                    _ cellModel: CellModel) -> Bool {
//        return true
//    }
//
//    func willBeginEditingCell(_ tableView: UITableView,
//                              _ indexPath: IndexPath,
//                              _ cellModel: CellModel) {
//        if let cell = tableView.cellForRow(at: indexPath) as? MessageCell {
//            cell.fadeOut(fade: true)
//        }
//    }
//
//    func didEndEditingRowAt(_ tableView: UITableView,
//                            _ indexPath: IndexPath,
//                            _ cellModel: CellModel) {
//        if let cell = tableView.cellForRow(at: indexPath) as? MessageCell {
//            cell.fadeOut(fade: false)
//        }
//    }
//}
