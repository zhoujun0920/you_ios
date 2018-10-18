//
//  BubbleInteractiveTransition.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import Foundation
import BubbleTransition

public enum BubbleInteractiveTransitionSwipeDirection: CGFloat {
    case up = -1
    case down = 1
}

open class BubbleInteractiveTransition: UIPercentDrivenInteractiveTransition {
    fileprivate var interactionStarted = false
    fileprivate var interactionShouldFinish = false
    fileprivate var controller: UIViewController?
    
    /// The threshold that grants the dismissal of the controller. Values from 0 to 1
    open var interactionThreshold: CGFloat = 0.3
    
    /// The swipe direction
    open var swipeDirection: BubbleInteractiveTransitionSwipeDirection = .down
    
    
    /// Attach the swipe gesture to a controller
    ///
    /// - Parameter to: the target controller
    open func attach(to: UIViewController) {
        controller = to
        controller?.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BubbleInteractiveTransition.handlePan(gesture:))))
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let controller = controller, let view = controller.view else { return }
        
        let translation = gesture.translation(in: controller.view.superview)
        
        let delta = swipeDirection.rawValue * (translation.y / view.bounds.height)
        let movement = fmaxf(Float(delta), 0.0)
        let percent = fminf(movement, 1.0)
        let progress = CGFloat(percent)
        
        switch gesture.state {
        case .began:
            interactionStarted = true
            controller.dismiss(animated: true, completion: nil)
        case .changed:
            interactionShouldFinish = progress > interactionThreshold
            update(progress)
        case .cancelled:
            interactionShouldFinish = false
            fallthrough
        case .ended:
            interactionStarted = false
            interactionShouldFinish ? finish() : cancel()
        default:
            break
        }
    }
}
