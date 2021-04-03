//
//  AppDelegate.swift
//  ZXHud
//
//  Created by luc xion on 2021/4/3.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.white
            self.window?.rootViewController = ViewController()
            self.window?.makeKeyAndVisible()
            return true
        }

}

