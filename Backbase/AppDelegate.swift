//
//  AppDelegate.swift
//  Backbase
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window!.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window!.makeKeyAndVisible()
        
        return true
    }
}
