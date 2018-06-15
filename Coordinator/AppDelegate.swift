//
//  AppDelegate.swift
//  Coordinator
//
//  Created by Tales Pinheiro De Andrade on 31/05/18.
//  Copyright © 2018 talesp. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        self.window = window
        self.rootCoordinator = AppCoordinator(window: window)
        self.rootCoordinator?.start()
        return true
    }

}
