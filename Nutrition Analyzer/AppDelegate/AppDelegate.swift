//
//  AppDelegate.swift
//  Nutrition Analyzer
//
//  Created by Mahmoud Eissa on 5/30/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Swizzler.swizzleForUI()
        setupRootViewController()
        return true
    }
    
    fileprivate func setupRootViewController() {
        window  = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: IngredientsViewController())
        window?.makeKeyAndVisible()
    }

}

