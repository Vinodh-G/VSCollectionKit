//
//  UIImage+Icons.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 12/03/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

extension UIImage {
    public static func icon(fileName: String, bundle: Bundle) -> UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(named: fileName, in: bundle, with: nil)
        } else {
            return UIImage(named: fileName, in: bundle, compatibleWith: nil)
        }
    }
}
