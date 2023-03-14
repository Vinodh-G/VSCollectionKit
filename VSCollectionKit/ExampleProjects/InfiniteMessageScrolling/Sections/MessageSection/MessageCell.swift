//
//  MessageCell.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 22/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit


class MessageCell: UICollectionViewCell {

    public static let messageCellIdentifier = String(describing: MessageCell.self)

    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var headerStackView: UIStackView!
    @IBOutlet private weak var titleStackView: UIStackView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!


    var cellModel: MessageCellModel? {
        didSet {
            if let viewModel = cellModel {
                configureView(for: viewModel)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(alpha: 1, animated: false)
    }

    func fadeOut(fade: Bool) {
        setCell(alpha: fade ? 0.6 : 1, animated: true)
    }

    private func configureView(for cellModel: MessageCellModel) {
        authorLabel.text = cellModel.authorName
        timeStampLabel.text = cellModel.timestamp
        messageLabel.text = cellModel.messageContent
        profileImageView.setImageFrom(imageURLString: cellModel.authorImageURL)
    }

    private func configureUI() {
        headerStackView.spacing = AppSpacing.spacingMedium
        titleStackView.spacing = AppSpacing.spacingSmall

        authorLabel.textColor = AppColor.ListCell.titleTextColor
        timeStampLabel.textColor = AppColor.ListCell.subTitleTextColor
        messageLabel.textColor = AppColor.ListCell.contentTextColor

        profileImageView.layer.cornerRadius = profileImageView.frame.midX
    }

    private func setCell(alpha: CGFloat, animated: Bool) {
        let viewComponents = [authorLabel, timeStampLabel, messageLabel, profileImageView]
        if animated {
            UIView.animate(withDuration: 0.3) {
                viewComponents.forEach { (view) in
                    view?.alpha = alpha
                }
            }
        } else {
            viewComponents.forEach { (view) in
                view?.alpha = alpha
            }
        }
    }
}
