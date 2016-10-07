//
//  RadialLayer.swift
//  SecureImage
//
//  Created by Aleksey on 20.07.16.
//  Copyright © 2016 Aleksey Chernish. All rights reserved.
//

import UIKit
import QuartzCore

final class RadialLayer: CALayer {
    
    var origin: CGPoint = .zero {
        didSet { setNeedsDisplay() }
    }
    
    var radius: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }
    
    override init() {
        super.init()
        
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setNeedsDisplay()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        guard key == "origin" || key == "radius" else { return super.needsDisplay(forKey: key) }
        
        return true
    }
    
    override func draw(in context: CGContext) {
        super.draw(in: context)
        
        let colors: [CGColor] = [
            radius == 0 ? UIColor.black.cgColor : UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.cgColor
        ]
        let colorSpace = UIColor.white.cgColor.colorSpace
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: [0, 0.66, 1])
        let endRadius = radius * 2 + 0.1
        let options = CGGradientDrawingOptions([.drawsAfterEndLocation])
        context.drawRadialGradient(gradient!, startCenter: origin, startRadius: radius, endCenter: origin, endRadius: endRadius, options: options)
    }
}
