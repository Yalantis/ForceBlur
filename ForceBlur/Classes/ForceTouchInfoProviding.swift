//
//  ForceTouchInfoProviding.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 15/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import UIKit

protocol ForceTouchInfoProviding: class {
    
    var forceTouchAvailable: Bool { get }
}

extension UIView: ForceTouchInfoProviding {
    
    var forceTouchAvailable: Bool {
        return UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == .available
    }
}
