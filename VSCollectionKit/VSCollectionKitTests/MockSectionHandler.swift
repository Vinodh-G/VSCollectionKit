//
//  MockSectionHandler.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit
import VSCollectionViewData
import UIKit

class MockSectionHandler: SectionHandler {
    var type: String {
        return "MockSection"
    }

    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(MockCollectionViewCell.self,
                                forCellWithReuseIdentifier: "mockCell")
        collectionView.register(MockHeaderView.self,
                                forSupplementaryViewOfKind: "section-header-element-kind",
                                withReuseIdentifier: "mockHeader")
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mockCell", for: indexPath) as! MockCollectionViewCell
        guard let viewModel = cellModel as? MockCellModel else { return cell }
        cell.textLabel.text = viewModel.info
        return cell
    }

    func supplementaryViewProvider(_ collectionView: UICollectionView,
                                   _ kind: String, _ indexPath: IndexPath,
                                   _ headerViewModel: HeaderViewModel) -> UICollectionReusableView? {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: "mockHeader",
                                                                   for: IndexPath(item: 11, section: 0)) as! MockHeaderView
        return view
    }

    func sectionLayoutProvider(_ sectionModel: SectionModel, _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(44))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        return NSCollectionLayoutSection(group: groupLayout)
    }
}

class MockCollectionViewCell: UICollectionViewCell {
    let textLabel: UILabel  = UILabel()
}

class MockHeaderView: UICollectionReusableView {

}

class MockLayoutEnvironment: NSObject, NSCollectionLayoutEnvironment {
    var container: NSCollectionLayoutContainer = MockLayoutContainer()
    var traitCollection: UITraitCollection = .current

    class MockLayoutContainer: NSObject, NSCollectionLayoutContainer {
        var contentSize: CGSize = .zero
        var effectiveContentSize: CGSize = .zero
        var contentInsets: NSDirectionalEdgeInsets = .zero
        var effectiveContentInsets: NSDirectionalEdgeInsets = .zero
    }
}
