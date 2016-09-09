//
//  KDDismissAnimatorController.swift
//  KDDismissAnimator
//
//  Created by Kedar Desai on 29/08/16.
//  Copyright © 2016 Kedar Desai. All rights reserved.
//

import UIKit

class KDDismissAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   Public variables that can be set from outside with some default values
     *  @createdOn  :   30th August, 2016
     */
    /// This sets the time of transition that has to be applied.  By default, its 0.6
    var transitionDuration: NSTimeInterval = 0.6
    
    /// This sets the delay time for transition. By default, its 0.0
    var transitionDelay: NSTimeInterval = 0.0
    
    
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method return duration of transition that has been applied while dismissing presented modal view controller.
     *  @createdOn  :   30th August, 2016
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method animates the presented modal view controller while dismissing presented modal view controller.
     *  @createdOn  :   30th August, 2016
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // Set up destination and source view controllers
        guard
            let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let destViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
        else {
            return
        }
        
        // Add "destViewController" the view controller
        containerView.insertSubview(destViewController.view, belowSubview: sourceViewController.view)
        
        // Create an animation
        let screenBounds = UIScreen.mainScreen().bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
            sourceViewController.view.frame = finalFrame
        }, completion: { _ in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}
