//
//  TweenLayer.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 15/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import UIKit

protocol TweenLayerDelegate: class {
    
    func tweenLayer(_ layer: TweenLayer, didSetAnimatableProperty to: CGFloat) -> Void
    func tweenLayerDidStopAnimation(_ layer: TweenLayer) -> Void
}

class TweenLayer: CALayer {
    
    var animationDelegate: TweenLayerDelegate?
    
    var from: CGFloat = 0
    var to: CGFloat = 0
    var tweenDuration: TimeInterval = 0
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    var delay: TimeInterval = 0
    
    fileprivate var animationBlocked = false
    @NSManaged fileprivate var animatableProperty: CGFloat
    
    override class func needsDisplay(forKey event: String) -> Bool {
        return event == "animatableProperty" ? true : super.needsDisplay(forKey: event)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if animationBlocked { return nil }
        if event != "animatableProperty" { return super.action(forKey: event) }
        
        let animation = CABasicAnimation(keyPath: event)
        animation.timingFunction = timingFunction
        animation.fromValue = from
        animation.toValue = to
        animation.duration = tweenDuration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.delegate = self
        
        return animation;
    }
    
    override func display() {
        if let value = presentation()?.animatableProperty {
            animationDelegate?.tweenLayer(self, didSetAnimatableProperty: value)
        }
    }
    
    func startAnimation() {
        withoutAnimation { self.animatableProperty = self.from }
        animatableProperty = to
    }
    
    fileprivate func withoutAnimation(_ action: (Void) -> Void) {
        animationBlocked = true
        action()
        animationBlocked = false
    }
}

extension TweenLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDelegate?.tweenLayer(self, didSetAnimatableProperty: to)
        animationDelegate?.tweenLayerDidStopAnimation(self)
    }
}
