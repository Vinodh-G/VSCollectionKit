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


fileprivate struct SupplymentryViewConstant {
    struct Header {
        static let kind = "section-header-element-kind"
        static let element = "section-element"
    }
    
    struct Footer {
        static let kind = "section-footer-element-kind"
        static let element = "section-element"
    }
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
        
        registedPlaceholderSupplymentryView(for: collectionView)
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.sectionHandler.cell(for: collectionView,
                                        indexPath: indexPath,
                                        collectionViewData: snapshot())
        
    }
    
    public override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let emptyView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SupplymentryViewConstant.Header.element, for: indexPath)
        
        return sectionHandler.supplementaryView(collectionView: collectionView,
                                                kind: kind,
                                                indexPath: indexPath,
                                                collectionViewData: snapshot()) ?? emptyView
    }
    
    private func registedPlaceholderSupplymentryView(for collectionView: UICollectionView) {
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: SupplymentryViewConstant.Header.kind, withReuseIdentifier: SupplymentryViewConstant.Header.element)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: SupplymentryViewConstant.Footer.kind, withReuseIdentifier: SupplymentryViewConstant.Footer.element)
    }
}
