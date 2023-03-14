//
//  LoadMoreCell.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 17/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

class LoadMoreCell: UICollectionViewCell {

    static let loadMoreCellIdentifier = String(describing: LoadMoreCell.self)
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = AppColor.LoadMoreCell.activityIndicatorColor
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }

    private func setUpView() {
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.readableContentGuide.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AppSpacing.spacingMedium),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AppSpacing.spacingMedium),
        ])

        activityIndicator.startAnimating()
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
