//
//  VNCollectionViewController.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionViewData

open class VSCollectionViewController: UIViewController {

    public var collectionView: UICollectionView!
    public var collectionViewLayout: UICollectionViewLayout!
    public var dataProvider: VSCollectionViewDataSourceAPI!
    public var delegateHandler: VSCollectionViewDelegateAPI!
    public var layoutProvider: VSCollectionViewLayoutProviderAPI!
    public var sectionHandler: VSCollectionViewSectionHandlerAPI = VSCollectionViewSectionHandller()

    open override func viewDidLoad() {
        super.viewDidLoad()
        willAddSectionControllers()
        configureCollectionView()
        configureLayoutProvider()
        configureDataSource()
        configureDelegate()
    }

    open func willAddSectionControllers() { }

    open func configureDataSource() {
        dataProvider = VSCollectionViewDataSource(collectionView: collectionView,
                                                  sectionHandler: sectionHandler)
    }

    open func configureDelegate() {
        guard let sectionDelegateHandler = sectionHandler as? VSCollectionViewSectionDelegateHandlerAPI else { return }
        delegateHandler = VSCollectionViewDelegate(collectionView: collectionView,
                                                   sectionHandler: sectionDelegateHandler)
    }

    open func configureLayoutProvider() {
        guard let sectionLayoutHandler = sectionHandler as? VSCollectionViewSectionLayoutHandlerAPI else {
            fatalError("Layout Provider not configured, without which the collection will not be able to render the cells")
        }
        layoutProvider = VSCollectionViewLayoutProvider(collectionView: collectionView,
                                                        sectionHandler: sectionLayoutHandler)
    }

    open func apply(collectionData: VSCollectionViewData, animated: Bool) {
        delegateHandler.data = collectionData
        layoutProvider.data = collectionData
        dataProvider.apply(data: collectionData, animated: animated)
    }

    open func configureCollectionView() {

        collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (section, enviroment) -> NSCollectionLayoutSection? in
            return self?.layoutProvider.collectionLayout(for: section,
                                                  environment: enviroment)
        })

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
