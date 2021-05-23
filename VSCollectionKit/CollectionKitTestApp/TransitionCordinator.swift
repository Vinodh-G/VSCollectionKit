//
//  TransitionCordinator.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

class TransitionCordinator: NSObject, UINavigationControllerDelegate {

    let animator: ZoomAnimator = ZoomAnimator()
    weak var fromDelegate: ZoomAnimatorDelegate?
    weak var toDelegate: ZoomAnimatorDelegate?

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            animator.transitionType = .zoomIn
            animator.fromDelegate = fromDelegate
          return animator
        case .pop:

          animator.transitionType = .zoomOut
          animator.fromDelegate = fromDelegate
          animator.toDelegate = toDelegate
          return animator
        default:
          return nil
        }
    }
}
