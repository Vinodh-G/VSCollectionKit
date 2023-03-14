//
//  VSSectionHandler+Prefetcher.swift
//  VSCollectionKit
//
//  Created by Vinodh Swamy on 11/03/23.
//  Copyright © 2023 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSCollectionViewPreFetcherAPI {
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath])
    
    func collectionView(_ collectionView: UICollectionView,
                        cancelPrefetchingForItemsAt indexPaths: [IndexPath])
}

public typealias PreFetchDidTrigger = (_ indexPaths: [IndexPath]) -> Void
public typealias PreFetchDidCancel = (_ indexPaths: [IndexPath]) -> Void

extension VSCollectionViewSectionHandller: VSCollectionViewPreFetcherAPI {
    
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        collectionViewController?.preFetchDidTrigger?(indexPaths)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        collectionViewController?.preFetchDidCancel?(indexPaths)
    }
}
