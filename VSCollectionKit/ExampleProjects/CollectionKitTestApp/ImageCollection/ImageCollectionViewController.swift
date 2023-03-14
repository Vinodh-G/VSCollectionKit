//
//  ImageCollectionViewController.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit
import UIKit

class ImageCollectionViewController: VSCollectionViewController {

    let viewModel: ImageCollectionViewModel
    
    init(viewModel: ImageCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var sectionHandlerTypes: [String : SectionHandler.Type] {
        return [ImageCollectionSection.photos.rawValue: ImageCollectionSectionHandler.self]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let data = viewModel.collectionData
        let selectedIndex = viewModel.selectedIndex
        
        apply(collectionData: data)

        collectionView.bounces = false
        
        addGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let selectedIndex = viewModel.selectedIndex
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
    }
    
    private func addGestures() {
        let swipeDownGesture = UISwipeGestureRecognizer()
        swipeDownGesture.direction = .down
        swipeDownGesture.addTarget(self, action: #selector(swipeToDissmiss(_:)))
        view.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc func swipeToDissmiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
