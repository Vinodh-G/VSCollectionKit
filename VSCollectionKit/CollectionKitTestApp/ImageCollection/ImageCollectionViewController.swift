//
//  ImageCollectionViewController.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit

class ImageCollectionViewController: VSCollectionViewController {

    var viewModel: ImageCollectionViewModel?

    override func willAddSectionControllers() {
        super.willAddSectionControllers()
        sectionHandler.addSectionHandler(handler: ImageCollectionSectionHandler(transitionCordinator: TransitionCordinator()))
    }

    override func configureCollectionView() {
        super.configureCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data = viewModel?.collectionData,
            let selectedIndex = viewModel?.selectedIndex  else { return }
        apply(collectionData: data, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
    }
}
