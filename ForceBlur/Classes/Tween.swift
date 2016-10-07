//
//  CAAnimationGroup+Sequence.swift
//  EatFit
//
// Created by aleksey on 14.09.15.
// Copyright (c) 2015 aleksey chernish. All rights reserved.
//

import UIKit

class Tween {
    
    let object: UIView
    let key: String
    
    var timingFunction: CAMediaTimingFunction {
        set {
            layer.timingFunction = newValue
        }
        get {
            return layer.timingFunction
        }
    }

    var mapper: ((_ value: CGFloat) -> (AnyObject))?
    
    fileprivate weak var layer: TweenLayer!
    
    init(object: UIView, key: String, from: CGFloat = 0, to: CGFloat, duration: TimeInterval = 0.5, timingFunction: CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)) {
        self.object = object
        self.key = key
        
        layer = {
            let layer = TweenLayer()
            layer.from = from
            layer.to = to
            layer.tweenDuration = duration
            layer.animationDelegate = self
            object.layer.addSublayer(layer)
            
            return layer
        }()
    }
    
    func start(delay: TimeInterval = 0) {
        layer.delay = delay
        layer.startAnimation()
    }
}

extension Tween: TweenLayerDelegate {
    
    func tweenLayer(_ layer: TweenLayer, didSetAnimatableProperty to: CGFloat) {
        if let mapper = mapper {
            object.setValue(mapper(to), forKeyPath: key)
        } else {
            object.setValue(to, forKeyPath: key)
        }
    }
    
    func tweenLayerDidStopAnimation(_ layer: TweenLayer) {
        layer.removeFromSuperlayer()
    }
}

extension UIView {
    
    func stopPerformingTweens() {
        layer.sublayers?
            .flatMap { $0 as? TweenLayer }
            .forEach { $0.removeFromSuperlayer() }
    }
}
