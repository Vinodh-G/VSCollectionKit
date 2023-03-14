//
//  ZoomAnimator.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 03/05/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit

protocol ZoomAnimatorDelegate: class {
    var transactionImage: UIImage? { get }
    var sourceFrame: CGRect? { get }
    var destinationFrame: CGRect? { get }

    func willBeginTransaction()
    func didEndTransaction()
}

class ZoomAnimator: NSObject {

    enum TransitionType {
        case zoomIn
        case zoomOut
    }

    weak var fromDelegate: ZoomAnimatorDelegate?
    weak var toDelegate: ZoomAnimatorDelegate?

    var transitionType: TransitionType = .zoomIn
    var transitionDuration: TimeInterval = 0.5

    var transitionImageView: UIImageView?

    private func zoomIn(transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to),
            let fromDelegate = fromDelegate,
            let sourceFrame = fromDelegate.sourceFrame,
            let transitionImage = fromDelegate.transactionImage
            else { return }

        let containerView = transitionContext.containerView
        toView.alpha = 0
        containerView.addSubview(toView)

        fromDelegate.willBeginTransaction()
        toDelegate?.willBeginTransaction()

        if transitionImageView == nil {
            let imageView = UIImageView(image: transitionImage)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = sourceFrame
            imageView.clipsToBounds = true
            transitionImageView = imageView
            containerView.addSubview(imageView)
        }

        let finalFrame = imageFrame(for: transitionImage, on: toView)

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext),
                                              dampingRatio: 0.8) {

                                                self.transitionImageView?.frame = finalFrame
                                                toView.alpha = 1
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(true)
            fromDelegate.didEndTransaction()
            self.toDelegate?.didEndTransaction()

            self.transitionImageView?.removeFromSuperview()
            self.transitionImageView = nil
        }

        animator.startAnimation()
    }

    private func zoomOut(transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let fromDelegate = fromDelegate,
            let destinationFrame = toDelegate?.destinationFrame,
            let transitionImage = fromDelegate.transactionImage
            else { return }

        let containerView = transitionContext.containerView
        toView.alpha = 0
        fromView.alpha = 0
        containerView.addSubview(toView)

        fromDelegate.willBeginTransaction()
        toDelegate?.willBeginTransaction()

        let sourceFrame = imageFrame(for: transitionImage,
                                     on: fromView)

        if transitionImageView == nil {
            let imageView = UIImageView(image: transitionImage)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = sourceFrame
            imageView.clipsToBounds = true
            transitionImageView = imageView
            containerView.addSubview(imageView)
        }

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext),
                                              dampingRatio: 0.6) {
                                                self.transitionImageView?.frame = destinationFrame
                                                toView.alpha = 1
        }

        animator.addCompletion { (position) in
            transitionContext.completeTransition(true)
            fromDelegate.didEndTransaction()
            self.toDelegate?.didEndTransaction()

            self.transitionImageView?.removeFromSuperview()
            self.transitionImageView = nil
        }

        animator.startAnimation()
    }

    private func imageFrame(for image: UIImage, on view: UIView) -> CGRect{

        let viewFrame = view.convert(view.frame, to: nil)
        let imageRatio = image.size.width / image.size.height
        let viewRatio = view.bounds.size.width / view.bounds.size.height

        if imageRatio > viewRatio {
            let newHeight = view.frame.size.width / imageRatio
            return CGRect(x: viewFrame.origin.x,
                          y: 28 + (view.bounds.size.height - newHeight) / 2,
                          width: view.bounds.size.width,
                          height: newHeight)
        } else {
            let newWidth = view.frame.size.height * imageRatio
            return CGRect(x: viewFrame.origin.x + (view.bounds.size.width - newWidth) / 2,
                          y: viewFrame.origin.y,
                          width: newWidth,
                          height: view.bounds.size.height)
        }
    }
}

extension ZoomAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionType {
        case .zoomIn:
            zoomIn(transitionContext: transitionContext)
        case .zoomOut:
            zoomOut(transitionContext: transitionContext)
        }
    }
}
