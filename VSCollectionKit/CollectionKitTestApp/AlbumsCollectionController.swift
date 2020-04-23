//
//  AlbumsCollectionController.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit

enum AlbumSectionType: String {
    case photos
}

enum AlbumCellType: String {
    case photos
}

class AlbumsCollectionController: VSCollectionViewController {

    var viewModel: AlbumCollectionViewAPI?

    override func willAddSectionControllers() {
        super.willAddSectionControllers()
        let photSectionHandler = PhotosSectionHandler()
        sectionHandler.addSectionHandler(handler: photSectionHandler)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "10 Mar 2020"
        viewModel?.fetchPhotos(callBack: { [weak self] (collectionData, errorString) in
            guard let self = self,
                let collectionData = collectionData else { return }
            self.apply(collectionData: collectionData, animated: true)
        })
    }
}
