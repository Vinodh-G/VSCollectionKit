//
//  AlbumsCollectionController.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit
import UIKit

enum AlbumSectionType: String {
    case photos
}

enum AlbumCellType: String {
    case photos
}

class AlbumsCollectionController: VSCollectionViewController {

    var viewModel: AlbumCollectionViewAPI & PhotosSelectionAPI
    init (viewModel: AlbumCollectionViewAPI & PhotosSelectionAPI) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willAddSectionControllers() {
        super.willAddSectionControllers()
//        let photSectionHandler = PhotosSectionHandler(sectionId: AlbumSectionType.photos.rawValue, photosSelection: viewModel)
//        sectionHandler.addSectionHandler(handler: photSectionHandler)
    }
    
    override var sectionHandlerTypes: [String : SectionHandler.Type] {
        return [AlbumSectionType.photos.rawValue: PhotosSectionHandler.self]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "10 Mar 2020"
        observeViewChanges()
        viewModel.fetchPhotos()
        
        configureNavBar()
    }
    
    private func observeViewChanges() {
        viewModel.viewUpdateBlock = { [weak self] (collectionData, errorString) in
            guard let self = self,
                let collectionData = collectionData else { return }
            self.apply(collectionData: collectionData)
        }
    }
    
    private func configureNavBar() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
        let reloadButton = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(handleReload))
        
        self.navigationItem.leftBarButtonItem = reloadButton
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func handleEdit() {
        viewModel.isEditing = !viewModel.isEditing
    }
    
    @objc func handleReload() {
        
    }
}
