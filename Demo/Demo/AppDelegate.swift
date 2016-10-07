//
//  AppDelegate.swift
//  ChatDemo
//
//  Created by Serhii Butenko on 8/8/16.
//  Copyright © 2016 Serhii Butenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate lazy var rootViewController: UIViewController = {
        let chatView = ChatViewController()
        chatView.messages = DemoConversation
        return UINavigationController(rootViewController: chatView)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
