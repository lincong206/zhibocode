//
//  AppDelegate.swift
//  zhiboTV
//
//  Created by 林聪 on 2022/12/4.
//  Copyright © 2022 Lynn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let tabbar = TabbarViewController.init()
        self.window?.rootViewController = tabbar
        self.window?.makeKeyAndVisible()
        return true
    }
}

