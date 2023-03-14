//
//  ErrorCell.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 23/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit

protocol ErrorActionDelegate: AnyObject {
    func didTapOn(cell: ErrorCell, errorAction: String)
}

class ErrorCell: UICollectionViewCell {

    public static let errorCellIdentifier = String(describing: ErrorCell.self)

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!

    weak var errorActionDelegate: ErrorActionDelegate?
    var cellModel: ErrorCellModel? {
        didSet {
            errorMessageLabel.text = cellModel?.errorMessage
            actionButton.setTitle(cellModel?.actionTitle,
                                  for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    private func setUpView() {
        actionButton.layer.borderWidth = 2
        actionButton.layer.borderColor = AppColor.ErrorCell.actionButtonBorder.cgColor
        actionButton.tintColor = AppColor.ErrorCell.actionButtonTint
        actionButton.layer.cornerRadius = 15
        errorMessageLabel.textColor = AppColor.ErrorCell.errorTitleColor
    }

    @IBAction func retryButtonAction(_ sender: Any) {
        errorActionDelegate?.didTapOn(cell: self, errorAction: cellModel?.actionTitle ?? "")
    }
}
