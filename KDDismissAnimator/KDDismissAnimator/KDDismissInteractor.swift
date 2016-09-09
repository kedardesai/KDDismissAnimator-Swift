//
//  KDDismissInteractor.swift
//  KDDismissAnimator
//
//  Created by Kedar Desai on 29/08/16.
//  Copyright © 2016 Kedar Desai. All rights reserved.
//

import UIKit

class KDDismissInteractor: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate {
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   Public variables that can be set from outside with some default values
     *  @createdOn  :   30th August, 2016
     */
    /// This sets the view controller that is to be presented. By default, its nil.
    var modalViewController: UIViewController? = nil
    
    /// This sets boolean value which specifies whether view has been completed transition or not. By default, its false.
    var shouldCompleteTransition = false
    
    /// This sets boolean value which specifies whether transition is in progress or not. By default, its false.
    var transitionInProgress = false
    
    /// This sets completion seed in percentage. This calls dynamically.
    var completionSeed: CGFloat {
        return 1 - percentComplete
    }
    
    
    
    // MARK: - Self Written Methods
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method adds a pan gesture to modal view controller that has been presented.
     *  @param      :   UIViewController that is to be presented.
     *  @createdOn  :   30th August, 2016
     */
    func attachToViewController(viewController: UIViewController) {
        
        modalViewController = viewController
        self.setupPanGestureRecognizer(viewController.view)
    }
    
    
    
    // MARK: - Gesture Recognizer Methods
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method sets up a pan gesture and adds it to the view of modal view controller that has been presented.
     *  @param      :   Presented view controller's default view that is to be presented.
     *  @createdOn  :   30th August, 2016
     */
    private func setupPanGestureRecognizer(view: UIView) {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(KDDismissInteractor.handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    
    /*!
     *  @author     :   Kedar Desai
     *  @desc       :   This method triggers when pan gesture added to the view of the modal view controller occurs.
     *  @param      :   UIPanGestureRecognizer which was attached to the view of modalled view controller.
     *  @createdOn  :   30th August, 2016
     */
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        let percentThreshold:CGFloat = 0.4
        
        // convert y-position to downward pull progress (percentage)
        let viewTranslation = panGesture.translationInView(panGesture.view!.superview!)
        let verticalMovement = viewTranslation.y / panGesture.view!.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        switch panGesture.state {
        case .Began:
            transitionInProgress = true
            modalViewController?.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            shouldCompleteTransition = progress > percentThreshold
            updateInteractiveTransition(progress)
            
        case .Cancelled, .Ended:
            transitionInProgress = false
            if !shouldCompleteTransition || panGesture.state == .Cancelled {
                cancelInteractiveTransition()
            } else {
                finishInteractiveTransition()
            }
            
        default:
            print("Swift switch must be exhaustive, thus the default")
        }
        
    }

}
