//
//  AlbumsCollectionController.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Combine
import UIKit
import VSCollectionKit

enum AlbumSectionType: String {
    case photos
}

enum AlbumCellType: String {
    case photos
}

class AlbumsCollectionController: VSCollectionViewController {

    init (viewModel: AlbumCollectionViewAPI) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: AlbumCollectionViewAPI
    private var cancelBag: Set<AnyCancellable> = []
    
    override var sectionHandlerTypes: [String : SectionHandler.Type] {
        return [AlbumSectionType.photos.rawValue: PhotosSectionHandler.self]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "10 Mar 2020"
        
        viewModel.collectionViewData
            .sink { [weak self] data in
                guard let self = self else { return }
                self.apply(collectionData: data)
            }
            .store(in: &cancelBag)
        
        viewModel.fetchPhotos()
        configureNavBar()
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
