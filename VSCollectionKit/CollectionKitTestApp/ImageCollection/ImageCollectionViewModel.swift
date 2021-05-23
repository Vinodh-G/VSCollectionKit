//
//  ImageCollectionViewModel.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit

class ImageCollectionViewModel {
    var collectionData: VSCollectionViewData
    var selectedIndex:  Int
    init(collectionData: VSCollectionViewData,  selectedIndex: Int) {
        self.collectionData = collectionData
        self.selectedIndex = selectedIndex
    }
}
