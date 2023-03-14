//
//  VNCollectionViewController.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol VSSectionHandler {
    var sectionHandlerTypes: [String: SectionHandler.Type] { get }
}

public typealias VSViewController = UIViewController & VSSectionHandler

open class VSCollectionViewController: VSViewController {

    public var collectionView: UICollectionView!
    public var collectionViewLayout: UICollectionViewLayout!
    public var dataProvider: VSCollectionViewDataSourceAPI!
    public var delegateHandler: VSCollectionViewDelegateAPI!
    public var layoutProvider: VSCollectionViewLayoutProviderAPI!
    public var sectionHandler: VSCollectionViewSectionHandlerAPI = VSCollectionViewSectionHandller()
    
    open var preFetchDidTrigger: PreFetchDidTrigger?
    open var preFetchDidCancel: PreFetchDidCancel?
    
    open var sectionHandlerTypes: [String: SectionHandler.Type] {
        fatalError("Subclass of VSCollectionViewController should override sectionHandlerTypes: [String: SectionHandler.Type]")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureLayoutProvider()
        configureDataSource()
        configureDelegate()
        sectionHandler.registerSectionHandlers(types: sectionHandlerTypes,
                                               collectionView: collectionView)
        sectionHandler.collectionViewController = self
    }

    open func willAddSectionControllers() { }

    open func configureDataSource() {
        dataProvider = VSCollectionViewDataSource(collectionView: collectionView,
                                                  sectionHandler: sectionHandler)
        collectionView.prefetchDataSource = dataProvider
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

    open func apply(collectionData: VSCollectionViewData) {
                
        delegateHandler.data = collectionData
        layoutProvider.data = collectionData

        dataProvider.apply(collectionData)
    }

    open func configureCollectionView() {

        collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (section, enviroment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.layoutProvider.collectionLayout(for: section,
                                                         collectionViewData: self.dataProvider.snapshot(),
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
