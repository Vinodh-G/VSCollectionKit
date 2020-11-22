//
//  VNSectionHandlerProtocol.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionViewData

public protocol SectionHandler: SectionLayoutInfo {
    var type: String { get }
    func registerCells(for collectionView: UICollectionView)
    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell
    
    var sectionHeaderFooterProvider: SectionHeaderFooterProvider? { get }
    var sectionDelegateHandler: SectionDelegateHandler? { get }
}

public protocol SectionHeaderFooterProvider: AnyObject {
    func supplementaryViewProvider(_ collectionView: UICollectionView,
                                   _ kind: String,
                                   _ indexPath: IndexPath,
                                   _ headerViewModel: HeaderViewModel) -> UICollectionReusableView?
}

public protocol SectionLayoutInfo: AnyObject {
    func sectionLayoutProvider(_ sectionModel: SectionModel,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

public protocol SectionDelegateHandler: AnyObject {
    func didSelect(_ collectionView: UICollectionView,
                   _ indexPath: IndexPath,
                   _ cellModel: CellModel)
    func willDisplayCell(_ collectionView: UICollectionView,
                         _ indexPath: IndexPath,
                         _ cell: UICollectionViewCell,
                         _ cellModel: CellModel)
}
