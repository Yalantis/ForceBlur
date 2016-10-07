//
//  ImageViewController.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 8/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet fileprivate var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        precondition(image != nil, "You must set image before presenting \(self)")
        imageView.image = image
    }
    
    @IBAction func close(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
