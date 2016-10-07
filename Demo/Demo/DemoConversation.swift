//
//  DemoConversation.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import JSQMessagesViewController
import ForceBlur

let WomanName = "Bae"
let WomanID = "woman"
let ManName = "I"
let ManID = "man"

let DemoConversation: [JSQMessage] = {
    let message1 = JSQMessage(senderId: WomanID, displayName: WomanName, text: "Hey! How u doing? Check this out! But be careful It's NSFW!🔒👀💦")!
    
    let photoItem: ForceBlurPhotoMediaItem = {
        let photoItem = ExampleForceBlurPhotoMediaItem(image: UIImage(named: "preview"))!
        photoItem.appliesMediaViewMaskAsOutgoing = false
        return photoItem
    }()
    let photoMessage2 = JSQMessage(senderId: WomanID, displayName: WomanName, media: photoItem)!
    
    let message3 = JSQMessage(senderId: ManID, displayName: ManName, text: "Daaamn! 😍🔥🔥")!
    
    return [message1, photoMessage2, message3]
}()
