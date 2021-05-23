//
//  VNCollectionViewSectionHandler.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewSectionHandlerAPI: AnyObject {
    func addSectionHandler(handler: SectionHandler)
    func removeSectionHandler(type: String)
    func registerCells(for collectionView: UICollectionView)
    func numOfRows(for sectionModel: SectionModel, sectionIndex: Int) -> Int
    
    func cell(for collectionView: UICollectionView,
              indexPath: IndexPath,
              sectionModel: SectionModel) -> UICollectionViewCell
    func supplementaryView(collectionView: UICollectionView,
                           kind: String,
                           indexPath: IndexPath,
                           sectionModel: SectionModel) -> UICollectionReusableView?
}

public class VSCollectionViewSectionHandller: VSCollectionViewSectionHandlerAPI {
        
    public init() {}

    private var sectionHandlers: [String: SectionHandler] = [:]

    public func addSectionHandler(handler: SectionHandler) {
        sectionHandlers[handler.type] = handler
    }

    public func removeSectionHandler(type: String) {
        sectionHandlers[type] = nil
    }

    public func registerCells(for collectionView: UICollectionView) {
        sectionHandlers.forEach { (arg0) in
            let (_, handler) = arg0
            handler.registerCells(for: collectionView)
        }
    }

    public func numOfRows(for sectionModel: SectionModel, sectionIndex: Int) -> Int {
        return sectionModel.cellItems.count
    }
    
    public func cell(for collectionView: UICollectionView,
              indexPath: IndexPath,
              sectionModel: SectionModel) -> UICollectionViewCell {
        let emptyCell = UICollectionViewCell()

        let sectionType = sectionModel.sectionType
        guard let sectionHandler = sectionHandlers[sectionType] else { return emptyCell }
        return sectionHandler.cellProvider(collectionView,
                                           indexPath,
                                           sectionModel.cellItems[indexPath.row])
    }

    public func supplementaryView(collectionView: UICollectionView,
                           kind: String,
                           indexPath: IndexPath,
                           sectionModel: SectionModel) -> UICollectionReusableView? {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType],
            let headerViewModel = sectionModel.header else { return nil }

        return sectionHandler.sectionHeaderFooterProvider?.supplementaryViewProvider(collectionView,
                                                        kind,
                                                        indexPath,
                                                        headerViewModel)
    }
}

public protocol VSCollectionViewSectionLayoutHandlerAPI: AnyObject {
    func collectionLayout(for sectionModel: SectionModel,
                          environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

extension VSCollectionViewSectionHandller: VSCollectionViewSectionLayoutHandlerAPI {
    
    public func collectionLayout(for sectionModel: SectionModel,
                          environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType] else { return nil }
        return sectionHandler.sectionLayoutProvider(sectionModel,
                                                    environment)
    }
}

public protocol VSCollectionViewSectionDelegateHandlerAPI: AnyObject {
    func willDisplayCell(collectionView: UICollectionView,
                         indexPath: IndexPath,
                         cell: UICollectionViewCell,
                         sectionModel: SectionModel)
    func didSelectItemAt(_ collectionView: UICollectionView,
                        indexPath: IndexPath,
                        sectionModel: SectionModel)
}

extension VSCollectionViewSectionHandller: VSCollectionViewSectionDelegateHandlerAPI {

    public func willDisplayCell(collectionView: UICollectionView,
                         indexPath: IndexPath,
                         cell: UICollectionViewCell,
                         sectionModel: SectionModel) {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType] else { return }
        sectionHandler.sectionDelegateHandler?.willDisplayCell(collectionView,
                                       indexPath,
                                       cell,
                                       sectionModel.cellItems[indexPath.row])
    }

    public func didSelectItemAt(_ collectionView: UICollectionView,
                        indexPath: IndexPath,
                        sectionModel: SectionModel) {
        guard let sectionHandler = sectionHandlers[sectionModel.sectionType] else { return }
        sectionHandler.sectionDelegateHandler?.didSelect(collectionView,
                                 indexPath,
                                 sectionModel.cellItems[indexPath.row])
    }
}
