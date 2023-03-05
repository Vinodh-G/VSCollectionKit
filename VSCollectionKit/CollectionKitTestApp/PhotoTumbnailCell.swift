//
//  PhotoTumbnailCell.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

class PhotoTumbnailCell: UICollectionViewCell {

    static let resuseId: String = String(describing: PhotoTumbnailCell.self)

    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }()

    lazy var selectionView: UIView = {
        let imageV = UIView()
        imageV.alpha = 0.5
        imageV.backgroundColor = .white
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.clipsToBounds = true
        return imageV
    }()

    
    var cellModel: PhotoCellModel? {
        didSet {
            guard let cellModel = cellModel else { return }
            imageView.image = UIImage(named: cellModel.photoURL)
            selectionView.alpha = cellModel.isSelected ? 0.8 : 0.0
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    private func setUpView() {
        contentView.addSubview(imageView)
        contentView.addSubview(selectionView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            selectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
