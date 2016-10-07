//
//  ForceBlurPhotoMediaItem.swift
//  SwiftExample
//
//  Created by Serhii Butenko on 5/8/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import Foundation
import JSQMessagesViewController

open class ForceBlurPhotoMediaItem: JSQPhotoMediaItem {
    
    open var secureImageView: ForceBlurImageView!
    
    fileprivate var chachedView: UIView?

    open override func mediaView() -> UIView? {
        guard let image = image else { return nil }
        guard chachedView == nil else { return chachedView! }
    
        secureImageView = ForceBlurImageView(image: image)
        secureImageView.frame = CGRect(origin: .zero, size: mediaViewDisplaySize())
        secureImageView.contentMode = .scaleAspectFill
        secureImageView.clipsToBounds = true
        JSQMessagesMediaViewBubbleImageMasker.applyBubbleImageMask(toMediaView: secureImageView, isOutgoing: appliesMediaViewMaskAsOutgoing)

        return secureImageView
    }
}
