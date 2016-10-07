//
//  PressureGestureRecognizer.swift
//  SecureImage
//
//  Created by Aleksey on 22.07.16.
//  Copyright © 2016 Aleksey Chernish. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class PressureGestureRecognizer: UILongPressGestureRecognizer {
    
    var minimumForce: CGFloat = 0.05
    var force: CGFloat = 0
    var pressureChange: ((CGFloat) -> Void)?
    
    fileprivate weak var provider: ForceTouchInfoProviding?
    
    init(target: ForceTouchInfoProviding, action: Selector) {
        self.provider = target
        
        super.init(target: target, action: action)
        
        cancelsTouchesInView = false
        delaysTouchesEnded = false
        
        allowableMovement = CGFloat.greatestFiniteMagnitude
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            updateForce(0)
            state = .failed
        }
        
        if !((provider ?? view)?.forceTouchAvailable ?? false) {
            updateForce(1)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        
        let touchInsideView = view?.bounds.contains(touch.location(in: view)) ?? false
        if !touchInsideView {
            updateForce(0)
            state = .failed
        
            return
        }
        
        let value = touch.force / touch.maximumPossibleForce
        
        if state == .possible {
            if value > minimumForce {
                state = .began
            }
        } else {
            if let provider = provider ?? view , provider.forceTouchAvailable {
                updateForce(value)
            } else {
                updateForce(1)
            }
            
            state = .changed
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        
        updateForce(0)
        state = .cancelled
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        
        updateForce(0)
        state = .ended
    }
    
    func updateForce(_ newForce: CGFloat) {
        force = newForce
    }
}
