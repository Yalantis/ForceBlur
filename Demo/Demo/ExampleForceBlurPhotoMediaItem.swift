
//
//  ExampleForceBlurPhotoMediaItem.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 9/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import ForceBlur

// Don't use the item in production
class ExampleForceBlurPhotoMediaItem: ForceBlurPhotoMediaItem {
    
    fileprivate var previousPercent: CGFloat = 0
    fileprivate let scaleThreshold: CGFloat = 0.1
    fileprivate let scale: CGFloat = 1.03
    
    override func mediaView() -> UIView? {
        let mediaView = super.mediaView()
        
        secureImageView.pressureChanged = { [weak self] pressure in
            guard let _self = self else {
                return
            }
            
            UIView.animate(withDuration: 0.15) {
                let viewToScale = _self.secureImageView.superview!.superview!.superview!
                
                if pressure > _self.scaleThreshold && _self.previousPercent < _self.scaleThreshold {
                    AudioServicesPlaySystemSound(1519)
                    viewToScale.transform = CGAffineTransform(scaleX: _self.scale, y: _self.scale)
                } else if pressure == 0 {
                    viewToScale.transform = .identity
                }
            }
    
            _self.previousPercent = pressure
        }
        
        return mediaView
    }
    
    override func mediaViewDisplaySize() -> CGSize {
        let oldSize = super.mediaViewDisplaySize()
        let aspectRatio = oldSize.height / oldSize.width
        let newWidth = UIScreen.main.bounds.width * 3 / 4
        let newHeight = newWidth * aspectRatio
        
        return CGSize(width: newWidth, height: newHeight)
    }
}
