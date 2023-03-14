//
//  LoadingSkeletonCell.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 16/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public class LoadingSkeletonCell: UICollectionViewCell {
    public static let loadingCellIdentifier = String(describing: LoadingSkeletonCell.self)

    @IBOutlet private weak var profileImageMaskView: UIImageView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var titleStackView: UIStackView!
    @IBOutlet private weak var headerStackView: UIStackView!
    @IBOutlet private weak var multiLineMessageStackView: UIStackView!

    private var gradientLayer : CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = LoadingCellUIConfig.GradiantConfig.gradientColors
        layer.locations = LoadingCellUIConfig.GradiantConfig.colorLocations
        layer.startPoint = LoadingCellUIConfig.GradiantConfig.startPoint
        layer.endPoint = LoadingCellUIConfig.GradiantConfig.endPoint

        return layer
    }()

    deinit {
        stopAnimating()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.bounds = contentView.layer.bounds
    }

    private func configureUI() {
        mainStackView.spacing = AppSpacing.spacingMedium
        headerStackView.spacing = AppSpacing.spacingMedium
        titleStackView.spacing = AppSpacing.spacingSmall

        profileImageMaskView.layer.cornerRadius = profileImageMaskView.frame.midX
        profileImageMaskView.backgroundColor = LoadingCellUIConfig.skeletonViewBackgroundColor
        titleStackView.subviews.forEach { (view) in
            view.backgroundColor = LoadingCellUIConfig.skeletonViewBackgroundColor
        }
        multiLineMessageStackView.subviews.forEach { (view) in
            view.backgroundColor = LoadingCellUIConfig.skeletonViewBackgroundColor
        }
    }

    public func startAnimating() {
        maskGradiantLayer()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = LoadingCellUIConfig.GradiantConfig.animationDuration
        animation.fromValue = LoadingCellUIConfig.GradiantConfig.animationStartPoint
        animation.toValue = LoadingCellUIConfig.GradiantConfig.animationEndPoint
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "loadingAnimation")
    }

    public func stopAnimating() {
        gradientLayer.removeAllAnimations()
        resetGradiantMask()
    }

    private func resetGradiantMask() {
        gradientLayer.colors = LoadingCellUIConfig.GradiantConfig.gradientColors
        gradientLayer.locations = LoadingCellUIConfig.GradiantConfig.colorLocations
        gradientLayer.startPoint = LoadingCellUIConfig.GradiantConfig.startPoint
        gradientLayer.endPoint = LoadingCellUIConfig.GradiantConfig.endPoint
        contentView.layer.mask = nil
    }

    private func maskGradiantLayer() {
        gradientLayer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        contentView.layer.mask = gradientLayer
    }
}

struct LoadingCellUIConfig {

    static let skeletonViewBackgroundColor: UIColor = UIColor.init(white: 0, alpha: 0.09)

    struct GradiantConfig {
        static let gradientColors: [CGColor] = [UIColor.white.cgColor,
                                                UIColor.clear.cgColor,
                                                UIColor.white.cgColor,
                                                UIColor.clear.cgColor,
                                                UIColor.white.cgColor]
        static let colorLocations: [NSNumber] = [0.0, 0.25, 0.5, 0.75, 1]
        static let startPoint: CGPoint = CGPoint(x: 0.0, y: 0.3)
        static let endPoint: CGPoint = CGPoint(x: 1, y: 0.65)

        static let animationDuration: CFTimeInterval = 2.5
        static let animationStartPoint: [NSNumber] = [-1, -0.75, -0.5, -0.25, 0]
        static let animationEndPoint: [NSNumber] = [1, 1.25, 1.5, 1.75, 2]
    }
}
