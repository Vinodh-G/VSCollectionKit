//
//  AppUIConfig.swift
//  InfiniteMessageScrolling
//
//  Created by Vinodh Swamy on 12/03/23.
//  Copyright © 2023 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public class AppColor {
    public struct ListCell {
        public static let titleTextColor: UIColor = UIColor.init(white: 0, alpha: 0.9)
        public static let subTitleTextColor: UIColor = UIColor.init(white: 0, alpha: 0.7)
        public static let contentTextColor: UIColor = UIColor.init(white: 0, alpha: 0.9)
    }

    public struct LoadMoreCell {
        public static let activityIndicatorColor: UIColor = .darkGray
    }

    public struct ErrorCell {
        public static let errorTitleColor: UIColor = .darkGray
        public static let actionButtonTint: UIColor = UIColor.init(white: 0, alpha: 0.7)
        public static let actionButtonBorder: UIColor = UIColor.init(white: 0, alpha: 0.3)
    }

    public static let viewBackgroundColor: UIColor = UIColor.init(white: 0, alpha: 0.3)
}

public class AppSpacing {

    public static let spacingXSmall: CGFloat = 4
    public static let spacingSmall: CGFloat = 8
    public static let spacingMedium: CGFloat = 12
    public static let spacingLarge: CGFloat = 16

    public static let cornerSpacing: CGFloat = 20
    public static let interLabelSpacing: CGFloat = 12

    public static let cellProfileImageHeight: CGFloat = 60
    public static let cellProfileImageWidth: CGFloat = 60

    public static let titleInterLableSpacing: CGFloat = 12

}
