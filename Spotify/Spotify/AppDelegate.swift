//
//  AppDelegate.swift
//  Spotify
//
//  Created by Mészáros Kristóf on 2022. 05. 05..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .spotifyBlack
        window?.makeKeyAndVisible()
        
//        let navigatorController = UINavigationController(rootViewController: TitleBarController())
//        window?.rootViewController = navigatorController
        
        window?.rootViewController = HomeController()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack
        
        return true
    }

}

