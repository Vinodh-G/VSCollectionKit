//
//  VNSectionHandlerProtocol.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public protocol SectionLayoutInfo: AnyObject {
    func sectionLayoutProvider(_ sectionViewData: SectionViewData,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

public protocol SectionHandler: SectionLayoutInfo {
    init(sectionType: String, sectionId: String)
    var type: String { get }
    var sectionId: String { get }
    func registerCells(for collectionView: UICollectionView)
    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellViewData: CellViewData) -> UICollectionViewCell
    
    var sectionHeaderFooterProvider: SectionHeaderFooterProvider? { get }
    var sectionDelegateHandler: SectionDelegateHandler? { get set }
    var parentViewController: Weak<UIViewController>? { get set }
}

public protocol SectionHeaderFooterProvider: AnyObject {
    func registeHeaderFooterView(for collectionView: UICollectionView)
    func supplementaryViewProvider(_ collectionView: UICollectionView,
                                   _ kind: String,
                                   _ indexPath: IndexPath,
                                   _ headerViewData: SectionHeaderViewData) -> UICollectionReusableView?
}


public protocol SectionDelegateHandler: AnyObject {
    func didSelect(_ collectionView: UICollectionView,
                   _ indexPath: IndexPath,
                   _ cellViewData: CellViewData)
    func willDisplayCell(_ collectionView: UICollectionView,
                         _ indexPath: IndexPath,
                         _ cell: UICollectionViewCell,
                         _ cellViewData: CellViewData)
}

public class Weak<T: AnyObject> {
  public weak var reference : T?
  init (reference: T?) {
    self.reference = reference
  }
}

public extension SectionHandler {
    var parentViewController: Weak<UIViewController>? {
        return nil
    }
}
