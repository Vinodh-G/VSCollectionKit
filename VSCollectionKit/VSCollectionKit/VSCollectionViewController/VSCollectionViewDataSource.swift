//
//  VNDataSource.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewDataSourceAPI: UICollectionViewDiffableDataSource<SectionSnapshot, CellSnapshot> {
}

public class VSCollectionViewDataSource: UICollectionViewDiffableDataSource<SectionSnapshot, CellSnapshot>,
                                        VSCollectionViewDataSourceAPI {
    
    unowned private var sectionHandler: VSCollectionViewSectionHandlerAPI
    unowned private var collectionView: UICollectionView

    init(collectionView: UICollectionView, sectionHandler: VSCollectionViewSectionHandlerAPI) {
        self.sectionHandler = sectionHandler
        self.collectionView = collectionView
        
        super.init(collectionView: collectionView) { (_, _, _) -> UICollectionViewCell? in
            return nil
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currSnapshot = snapshot()
        let sectionSnapshot = currSnapshot.sectionIdentifiers[indexPath.section]
        return self.sectionHandler.cell(for: collectionView,
                                        indexPath: indexPath,
                                        sectionModel: sectionSnapshot.sectionModel)
        
    }
}
