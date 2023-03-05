//
//  MockSectionHandler.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit
import UIKit

enum MockSectionType: String {
    case mockSection1
}

class MockSectionHandler: SectionHandler {
    
    var sectionId: String
    var type: String
    
    var sectionDelegateHandler: SectionDelegateHandler? = nil
    var sectionHeaderFooterProvider: SectionHeaderFooterProvider?

    required init(sectionType: String, sectionId: String) {
        self.sectionId = sectionId
        self.type = sectionType
        sectionHeaderFooterProvider = MockerHeaderFooterProvider()
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(MockCollectionViewCell.self,
                                forCellWithReuseIdentifier: "mockCell")
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellViewData) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mockCell", for: indexPath) as! MockCollectionViewCell
        guard let viewModel = cellModel as? MockCellModel else { return cell }
        cell.textLabel.text = viewModel.info
        return cell
    }

    func sectionLayoutProvider(_ sectionModel: SectionViewData, _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(44))
        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                           subitems: [itemLayout])
        let layoutSection = NSCollectionLayoutSection(group: groupLayout)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(44)),
            elementKind: "section-header-element-kind",
            alignment: .top)
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        return layoutSection
    }
}

class MockCollectionViewCell: UICollectionViewCell {
    let textLabel: UILabel  = UILabel()
}

class MockHeaderView: UICollectionReusableView {}

class MockerHeaderFooterProvider: SectionHeaderFooterProvider {
    
    func registeHeaderFooterView(for collectionView: UICollectionView) {
        collectionView.register(MockHeaderView.self, forSupplementaryViewOfKind: "section-header-element-kind", withReuseIdentifier: "mockHeader")
    }
    
    func supplementaryViewProvider(_ collectionView: UICollectionView, _ kind: String, _ indexPath: IndexPath, _ headerViewModel: SectionHeaderViewData) -> UICollectionReusableView? {
        return MockHeaderView()
    }
}

class MockLayoutEnvironment: NSObject, NSCollectionLayoutEnvironment {
    var container: NSCollectionLayoutContainer = MockLayoutContainer()
    var traitCollection: UITraitCollection = .current

    class MockLayoutContainer: NSObject, NSCollectionLayoutContainer {
        var contentSize: CGSize = UIScreen.main.bounds.size
        var effectiveContentSize: CGSize = .zero
        var contentInsets: NSDirectionalEdgeInsets = .zero
        var effectiveContentInsets: NSDirectionalEdgeInsets = .zero
    }
}
