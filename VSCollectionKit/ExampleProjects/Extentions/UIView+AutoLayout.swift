//
//  UIView+AutoLayout.swift
//  MesengerShared
//
//  Created by Vinodh Govindaswamy on 20/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

public extension UIView {
    convenience init(autoLayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !autoLayout
    }
}
