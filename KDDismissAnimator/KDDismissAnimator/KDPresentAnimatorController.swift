//
//  KDPresentAnimatorController.swift
//  KDDismissAnimator
//
//  Created by Kedar Desai on 29/08/16.
//  Copyright © 2016 Kedar Desai. All rights reserved.
//

import UIKit

class KDPresentAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   Public variables that can be set from outside with some default values
     *  @createdOn  :   30th August, 2016
     */
    /// This sets the time of transition that has to be applied. By default, its 1.2
    var transitionDuration: NSTimeInterval = 1.2
    
    /// This sets the delay time for transition. By default, its 0.0
    var transitionDelay: NSTimeInterval = 0.0
    
    /// This sets springing effect's damping. By default, its 0.5
    var springWithDamping: CGFloat = 0.5
    
    /// This sets springing effect's valocity. By default, its 0.0
    var springValocity: CGFloat = 0.0
    
    /// This sets corner radious for presented view controller. By default, its 10.0
    var cornerRadius: CGFloat = 10.0
    
    /// This sets border width for presented view controller. By default, its 0.6
    var borderWidth: CGFloat = 0.6
    
    /// This sets border color for presented view controller.  By default, its grayColor
    var borderColor: UIColor = UIColor.grayColor()
    
    
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method return duration of transition that has been applied while presenting presented modal view controller.
     *  @createdOn  :   30th August, 2016
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method animates the presented modal view controller while presenting presented modal view controller.
     *  @createdOn  :   30th August, 2016
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let sourceViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            let destinationViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let containerView = transitionContext.containerView()
        else {
            return
        }
        
        let bounds = UIScreen.mainScreen().bounds
        let finalFrameForVC = transitionContext.finalFrameForViewController(destinationViewController)
        destinationViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
        
        // Make corner angled
        destinationViewController.view.layer.cornerRadius = cornerRadius
        
        // Set Border for view
        destinationViewController.view.layer.borderWidth = borderWidth
        destinationViewController.view.layer.borderColor = borderColor.CGColor
        
        // Adding to view as subview to container view
        containerView.addSubview(destinationViewController.view)
        
        // Create an animation
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: transitionDelay, usingSpringWithDamping: springWithDamping, initialSpringVelocity: springValocity, options: .CurveLinear, animations: {
            
                sourceViewController.view.alpha = 0.5
                destinationViewController.view.frame = finalFrameForVC
            }, completion: {
                
                finished in
                transitionContext.completeTransition(true)
                sourceViewController.view.alpha = 1.0
        })
    }
}
