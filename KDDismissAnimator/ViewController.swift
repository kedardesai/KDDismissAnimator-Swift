//
//  ViewController.swift
//  KDDismissAnimator
//
//  Created by Kedar Desai on 29/08/16.
//  Copyright © 2016 Kedar Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1. variables to be used
    let transitionController: KDTransitionController = KDTransitionController()
    
    
    // MARK: - UIViewLifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showModal" {
            let destVC = segue.destinationViewController as! ModalViewController
            
            // 2. Assign transitioningDelegate
            destVC.transitioningDelegate = transitionController
            
            // 3. Attach destination view controller to dismissInteractor
            transitionController.dismissInteractor.attachToViewController(destVC)
        }
    }
}

