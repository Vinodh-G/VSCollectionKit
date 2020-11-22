//
//  PhotosSectionHandler.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit
import VSCollectionViewData

class PhotosSectionHandler: SectionHandler {
    
    var sectionHeaderFooterProvider: SectionHeaderFooterProvider? = nil
    var sectionDelegateHandler: SectionDelegateHandler? = nil
    
    var type: String {
        return AlbumSectionType.photos.rawValue
    }

    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(PhotoTumbnailCell.self, forCellWithReuseIdentifier: PhotoTumbnailCell.resuseId)
    }

    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoTumbnailCell.resuseId,
                                                            for: indexPath) as? PhotoTumbnailCell,
            let photoCellModel = cellModel as? PhotoCellModel else {
                                                                return UICollectionViewCell()
        }

        cell.cellModel = photoCellModel
        return cell
    }

    func sectionLayoutProvider(_ sectionModel: SectionModel,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {


        let groupLayout = NSCollectionLayoutGroup.vertical(layoutSize: LayoutSizeInfo.mainGroupLayoutSize,
                                                           subitems: [fullWidthLayout(),
                                                                      bigItemWithTwoVerticalPair(),
                                                                      tripletLayout()])
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        return sectionLayout
    }

    private func fullWidthLayout() -> NSCollectionLayoutItem {

        let itemLayout = NSCollectionLayoutItem(layoutSize: LayoutSizeInfo.FullWidthLayout.fullWidthLayoutSize)
        itemLayout.contentInsets = LayoutSizeInfo.FullWidthLayout.fullWidthContentInset
        return itemLayout
    }

    private func bigItemWithTwoVerticalPair() -> NSCollectionLayoutGroup {

        let mainItemLayout = NSCollectionLayoutItem(layoutSize: LayoutSizeInfo.MainWithTwoPairLayout.mainItemLayoutSize)
        mainItemLayout.contentInsets = LayoutSizeInfo.MainWithTwoPairLayout.mainItemContentInset


        let pairItemLayout = NSCollectionLayoutItem(layoutSize: LayoutSizeInfo.MainWithTwoPairLayout.pairItemSize)
        pairItemLayout.contentInsets = LayoutSizeInfo.MainWithTwoPairLayout.pairItemContentInset


        let pairGroupLayout = NSCollectionLayoutGroup.vertical(layoutSize: LayoutSizeInfo.MainWithTwoPairLayout.pairItemGroupSize,
                                                               subitem: pairItemLayout,
                                                               count: 2)

        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: LayoutSizeInfo.MainWithTwoPairLayout.mainGroupSize,
                                                             subitems: [mainItemLayout, pairGroupLayout])
        return groupLayout
    }

    private func tripletLayout() -> NSCollectionLayoutGroup {
        let itemLayout = NSCollectionLayoutItem(layoutSize: LayoutSizeInfo.TripleItemLayout.tripleItemSize)
        itemLayout.contentInsets = LayoutSizeInfo.TripleItemLayout.tripleItemContentInset

        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: LayoutSizeInfo.TripleItemLayout.tripleItemGroupSize,
                                                             subitem: itemLayout,
                                                             count: 3)
        return groupLayout
    }
}

// ------------------------------------------------------------------------------------ //
//
//            FullWidthLayoutItem
//            ---------------------------------
//            -                               -
//            -                               -
//            -               A               -
//            -                               -
//            -                               -
//            ---------------------------------

//            MainWithTwoPairItem
//            ---------------------------------
//            -                  -            -
//            -                  -     B      -
//            -                  -            -
//            -         A        --------------
//            -                  -            -
//            -                  -      C     -
//            -                  -            -
//            ---------------------------------

//            TripletItem
//            ---------------------------------
//            -         -          -          -
//            -    A    -     B    -     C    -
//            -         -          -          -
//            ---------------------------------
//
// ------------------------------------------------------------------------------------ //

struct LayoutSizeInfo {

    struct FullWidthLayout {
        static let fullWidthItemHeight: CGFloat = 200
        static let fullWidthLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .absolute(fullWidthItemHeight))
        static let fullWidthContentInset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 0, trailing: 2)
    }

    struct MainWithTwoPairLayout {
        static let mainItemHeight: CGFloat = 172
        static let mainItemLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                               heightDimension: .absolute(mainItemHeight))
        static let mainItemContentInset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 0, trailing: 0)

        static let pairItemHeight: CGFloat = mainItemHeight / 2
        static let pairItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
        static let pairItemContentInset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 0, trailing: 0)
        static let pairItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                              heightDimension: .absolute(pairItemHeight * 2))
        static let mainGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                          heightDimension: .absolute(mainItemHeight))
    }

    struct TripleItemLayout {
        static let tripleItemHeight: CGFloat = 86
        static let tripleItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                           heightDimension: .fractionalHeight(1))
        static let tripleItemContentInset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 0, trailing: 0)
        static let tripleItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                heightDimension: .absolute(tripleItemHeight))
    }

    static let mainGroupLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .absolute(FullWidthLayout.fullWidthItemHeight +
                                                                MainWithTwoPairLayout.mainItemHeight +
                                                                TripleItemLayout.tripleItemHeight))
}

