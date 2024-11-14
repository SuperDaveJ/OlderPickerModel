//
//  DimmingPresentationController.swift
//  Alerts
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    
    lazy var dimmingView = UIView(frame: .zero)
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        dimmingView.frame = self.containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        
        dimmingView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
    
}
