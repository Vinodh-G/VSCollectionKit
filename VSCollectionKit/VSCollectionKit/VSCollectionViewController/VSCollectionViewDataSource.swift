//
//  VNDataSource.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionViewData

public class VSCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    unowned private var collectionView: UICollectionView
    private var data: VSCollectionViewData?
    unowned private var sectionHandler: VSCollectionViewSectionHandller
    public init(collectionView: UICollectionView,
         sectionHandler: VSCollectionViewSectionHandller) {
        self.collectionView = collectionView
        self.sectionHandler = sectionHandler
        super.init()
        collectionView.dataSource = self

        // TODO: Have to remove this
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: "section-header-element-kind",
                                withReuseIdentifier: "EmptyView")
        sectionHandler.registerCells(for:  collectionView)
    }

    public func apply(data: VSCollectionViewData,
                      animated: Bool) {
        handleCollectionView(collectionData: data)
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let collectionData = data else { return 0 }
        return collectionData.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let collectionData = data else { return 0 }
        return collectionData.sections[section].items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionData = data else { return UICollectionViewCell() }
        return sectionHandler.cell(for: collectionView,
                                   indexPath: indexPath,
                                   sectionModel: collectionData.sections[indexPath.section])
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {

        let dummyView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                        withReuseIdentifier: "EmptyView",
                                                                        for: indexPath)

        guard let collectionData = data else { return dummyView }
        return sectionHandler.supplementaryView(collectionView: collectionView,
                                                kind: kind,
                                                indexPath: indexPath,
                                                sectionModel: collectionData.sections[indexPath.section]) ?? dummyView
    }

    private func handleCollectionView(collectionData: VSCollectionViewData) {

        collectionView.performBatchUpdates({  

            data = collectionData
            let updates = collectionData.update.updates
            // TODO: Check for leaks
//            guard let self = self else { return }
            for update in updates {

                switch update.type {
                case .insert:
                    if let insertedSection = update.updatedSections {
                        collectionView.insertSections(insertedSection)
                    }
                    if let insertedRows = update.updatedRows {
                        let insertedItems = insertedRows.map{ IndexPath(item: $0.item, section: $0.section) }
                        collectionView.insertItems(at: insertedItems)
                    }
                case .delete:
                    if let deletedSection = update.updatedSections {
                        collectionView.deleteSections(deletedSection)
                    }
                    if let deletedRows = update.updatedRows {
                        let deletedItems = deletedRows.map{ IndexPath(item: $0.item, section: $0.section) }
                        collectionView.deleteItems(at: deletedItems)
                    }
                case .reload:
                    if let reloadSections = update.updatedSections {
                        collectionView.reloadSections(reloadSections)
                    }
                    if let reloadRows = update.updatedRows {
                        let updatedItems = reloadRows.map{ IndexPath(item: $0.item, section: $0.section) }
                        collectionView.reloadItems(at: updatedItems)
                    }
                }
            }
        }) { (completed) in

        }
    }
}
