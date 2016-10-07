 //
//  ChatViewController.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 8/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import UIKit
import JSQMessagesViewController
 
class ChatViewController: JSQMessagesViewController {
    
    var messages = DemoConversation
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = WomanName
        senderId = ManID
        senderDisplayName = ManName
        
        incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: .jsq_messageBubbleBlue())
        outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: .lightGray)

        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
    }

    // MARK: JSQMessagesViewController method overrides
    
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        messages.append(message!)
        
        finishSendingMessage(animated: true)
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        let media = ExampleForceBlurPhotoMediaItem(image: UIImage(named: "preview"))
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, media: media)
        messages.append(message!)
        
        finishSendingMessage(animated: true)
    }
    
    //MARK: JSQMessages CollectionView DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[(indexPath as NSIndexPath).item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        return messages[(indexPath as NSIndexPath).item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, didTapMessageBubbleAt indexPath: IndexPath) {
        let message = messages[(indexPath as NSIndexPath).item]
        if let image = (message.media as? JSQPhotoMediaItem)?.image {
            showImage(image)
        }
    }
    
    fileprivate func showImage(_ image: UIImage) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.image = image
        navigationController?.present(nc, animated: true, completion: nil)
    }
}
 
