//
//  AppDelegate.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/5/21.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        UITabBar.appearance().barTintColor = UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1)
       // UINavigationBar.appearance().tintColor = UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 109/255.0, green: 213/255.0, blue: 237/255.0, alpha: 1)
        
        return true
    }
}

