//
//  VNCollectionViewSectionHandler.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewSectionHandlerAPI: AnyObject, VSCollectionViewPreFetcherAPI {

    var sectionHandlers: [String: SectionHandler] { get }
    var collectionViewController: VSCollectionViewController? { get set }
    func registerSectionHandlers(types: [String: SectionHandler.Type],
                                        collectionView: UICollectionView)
    func removeSectionHandler(type: String)
    func numOfRows(for collectionViewData: VSCollectionViewData, sectionIndex: Int) -> Int
    func cell(for collectionView: UICollectionView,
              indexPath: IndexPath,
              collectionViewData: VSCollectionViewData) -> UICollectionViewCell
    func supplementaryView(collectionView: UICollectionView,
                           kind: String,
                           indexPath: IndexPath,
                           collectionViewData: VSCollectionViewData) -> UICollectionReusableView?
}

class VSCollectionViewSectionHandller: VSCollectionViewSectionHandlerAPI {
        
    init() { }
    
    weak var collectionView: UICollectionView? = nil
    weak var collectionViewController: VSCollectionViewController? = nil
    private var sectionHandlersType: [String: SectionHandler.Type] = [:]
    public var sectionHandlers: [String: SectionHandler] = [:]

    public func registerSectionHandlers(types: [String: SectionHandler.Type],
                                        collectionView: UICollectionView) {
        self.sectionHandlersType = types
        self.collectionView = collectionView
    }

    public func removeSectionHandler(type: String) {
        sectionHandlers[type] = nil
    }

    public func numOfRows(for collectionViewData: VSCollectionViewData, sectionIndex: Int) -> Int {
        return collectionViewData.numberOfItems(inSection: collectionViewData.sectionIdentifiers[sectionIndex])
    }
    
    public func cell(for collectionView: UICollectionView,
                     indexPath: IndexPath,
                     collectionViewData: VSCollectionViewData) -> UICollectionViewCell {
        let sectionSnapshot = collectionViewData.sectionIdentifiers[indexPath.section]
        let sectionHandler = sectionHandler(sectionSnapshot: sectionSnapshot)
        let cellViewData = collectionViewData.itemIdentifiers(inSection: sectionSnapshot)[indexPath.item]
        return sectionHandler.cellProvider(collectionView,
                                           indexPath,
                                           cellViewData.cellViewData)
    }

    public func supplementaryView(collectionView: UICollectionView,
                                  kind: String,
                                  indexPath: IndexPath,
                                  collectionViewData: VSCollectionViewData) -> UICollectionReusableView? {
        let sectionSnapshot = collectionViewData.sectionIdentifiers[indexPath.section]
        let sectionHandler = sectionHandler(sectionSnapshot: sectionSnapshot)
        guard let headerViewData = sectionSnapshot.viewData.header else { return nil }

        return sectionHandler.sectionHeaderFooterProvider?.supplementaryViewProvider(collectionView,
                                                                                     kind,
                                                                                     indexPath,
                                                                                     headerViewData)
    }
    
    private func sectionHandler(sectionSnapshot: SectionSnapshot) -> SectionHandler {
        let sectionType = sectionSnapshot.viewData.sectionType
        let sectionId = sectionSnapshot.viewData.sectionId
        guard let sectionHandler = sectionHandlers[sectionId] else {
            guard let newSectionType: SectionHandler.Type = sectionHandlersType[sectionType] else {
                fatalError("\(sectionHandlersType) doesnt not contain the sectionType: \(sectionType)")
            }
            
            let newSectionHandler = newSectionType.init(sectionType: sectionType, sectionId: sectionId)
            newSectionHandler.parentViewController = Weak(reference: collectionViewController)
            register(newSectionHandler: newSectionHandler)
            return newSectionHandler
        }
        return sectionHandler
    }
    
    private func register(newSectionHandler: SectionHandler) {

        sectionHandlers[newSectionHandler.sectionId] = newSectionHandler
        guard let collectionView = collectionView else { return }
        newSectionHandler.registerCells(for: collectionView)
        newSectionHandler.sectionHeaderFooterProvider?.registeHeaderFooterView(for: collectionView)
    }
}

public protocol VSCollectionViewSectionLayoutHandlerAPI: AnyObject {
    func collectionLayout(for collectionViewData: VSCollectionViewData,
                          section: Int,
                          environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

extension VSCollectionViewSectionHandller: VSCollectionViewSectionLayoutHandlerAPI {
    
    public func collectionLayout(for collectionViewData: VSCollectionViewData,
                                 section: Int,
                                 environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let sectionSnapshot = collectionViewData.sectionIdentifiers[section]
        let sectionHandler = sectionHandler(sectionSnapshot: sectionSnapshot)
        return sectionHandler.sectionLayoutProvider(sectionSnapshot.viewData,
                                                    environment)
    }
}

public protocol VSCollectionViewSectionDelegateHandlerAPI: AnyObject {
    func willDisplayCell(collectionView: UICollectionView,
                         indexPath: IndexPath,
                         cell: UICollectionViewCell,
                         collectionViewData: VSCollectionViewData)
    func didSelectItemAt(_ collectionView: UICollectionView,
                         indexPath: IndexPath,
                         collectionViewData: VSCollectionViewData)
}

extension VSCollectionViewSectionHandller: VSCollectionViewSectionDelegateHandlerAPI {

    public func willDisplayCell(collectionView: UICollectionView,
                                indexPath: IndexPath,
                                cell: UICollectionViewCell,
                                collectionViewData: VSCollectionViewData) {
        let sectionSnapshot = collectionViewData.sectionIdentifiers[indexPath.section]
        let sectionHandler = sectionHandler(sectionSnapshot: sectionSnapshot)
        let cellViewData = collectionViewData.itemIdentifiers(inSection: sectionSnapshot)[indexPath.item].cellViewData

        sectionHandler.sectionDelegateHandler?.willDisplayCell(collectionView,
                                                               indexPath,
                                                               cell,
                                                               cellViewData)
    }

    public func didSelectItemAt(_ collectionView: UICollectionView,
                                indexPath: IndexPath,
                                collectionViewData: VSCollectionViewData) {
        let sectionSnapshot = collectionViewData.sectionIdentifiers[indexPath.section]
        let sectionHandler = sectionHandler(sectionSnapshot: sectionSnapshot)
        let cellViewData = collectionViewData.itemIdentifiers(inSection: sectionSnapshot)[indexPath.item].cellViewData

        sectionHandler.sectionDelegateHandler?.didSelect(collectionView,
                                                         indexPath,
                                                         cellViewData)
    }
}
