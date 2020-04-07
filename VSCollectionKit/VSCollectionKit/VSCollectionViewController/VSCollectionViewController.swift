//
//  VNCollectionViewController.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

open class VSCollectionViewController: UIViewController {

    public var collectionView: UICollectionView!
    public var collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    public var dataProvider: VSCollectionViewDataSource?
    public var delegateHandler: VSCollectionViewDelegate?
    public var layoutProvider: VSCollectionViewLayoutProvider?

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureLayoutProvider()
        configureDataSource()
        configureDelegate()
    }

    open func configureDataSource() { }

    open func configureDelegate() { }

    open func configureLayoutProvider() {}

    open func configureCollectionView() {
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
