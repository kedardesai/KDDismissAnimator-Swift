//
//  KDTransitionController.swift
//  KDDismissAnimator
//
//  Created by Kedar Desai on 29/08/16.
//  Copyright © 2016 Kedar Desai. All rights reserved.
//

import UIKit

class KDTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   Public variables that can be set from outside with some default values
     *  @createdOn  :   30th August, 2016
     */
    /// An object of KDPresentAnimatorController
    let presentAnimator: KDPresentAnimatorController = KDPresentAnimatorController()
    
    /// An object of KDDismissAnimatorController
    let dismissAnimator: KDDismissAnimatorController = KDDismissAnimatorController()
    
    /// An object of KDDismissInteractor
    let dismissInteractor: KDDismissInteractor = KDDismissInteractor()
    
    
    // MARK: - UIViewControllerTransitioningDelegate Methods
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dismissInteractor.transitionInProgress ? dismissInteractor : nil
    }

}
