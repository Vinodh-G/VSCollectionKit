//
//  VNCollectionViewSectionHandler.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public class VSCollectionViewSectionHandller {

    public init() {}

    private var sectionHandlers: [String: SectionHandler] = [:]

    public func addSectionHandler(handler: SectionHandler) {
        sectionHandlers[handler.type] = handler
    }

    public func removeSectionHandler(handler: SectionHandler) {
        sectionHandlers[handler.type] = nil
    }

    public func registerCells(for collectionView: UICollectionView) {
        sectionHandlers.forEach { (arg0) in
            let (_, handler) = arg0
            handler.registerCells(for: collectionView)
        }
    }

    public func numOfRows(for sectionModel: SectionModel, sectionIndex: Int) -> Int {
        return sectionModel.items.count
    }

    public func cell(for collectionView: UICollectionView,
              indexPath: IndexPath,
              sectionModel: SectionModel) -> UICollectionViewCell {
        let emptyCell = UICollectionViewCell()

        let sectionType = sectionModel.sectionType
        guard let sectionHandler = sectionHandlers[sectionType] else { return emptyCell }
        return sectionHandler.cellProvider(collectionView,
                                           indexPath,
                                           sectionModel.items[indexPath.row])
    }

    func supplementaryView(collectionView: UICollectionView,
                           kind: String,
                           indexPath: IndexPath,
                           sectionModel: SectionModel) -> UICollectionReusableView? {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType],
            let headerViewModel = sectionModel.header else { return nil }

        return sectionHandler.supplementaryView(collectionView: collectionView,
                                                kind: kind,
                                                indexPath: indexPath,
                                                headerViewModel: headerViewModel)
    }
}

extension VSCollectionViewSectionHandller {
    func collectionLayout(for sectionModel: SectionModel,
                          environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType] else { return nil }
        return sectionHandler.collectionLayout(for: sectionModel,
                                               environment: environment)
    }
}

extension VSCollectionViewSectionHandller {

    func willDisplayCell(collectionView: UICollectionView,
                         indexPath: IndexPath,
                         cell: UICollectionViewCell,
                         sectionModel: SectionModel) {

    }

    func didSelectItemAt(_ collectionView: UICollectionView,
                        indexPath: IndexPath,
                        sectionModel: SectionModel) {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType] else { return }
        sectionHandler.didSelect(collectionView,
                                 indexPath,
                                 sectionModel.items[indexPath.row])
    }
}
