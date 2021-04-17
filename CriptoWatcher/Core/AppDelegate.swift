//
//  AppDelegate.swift
//  CriptoWatcher
//
//  Created by Mauricio Chirino on 17/4/21.
//

import UIKit

@main
 final class AppDelegate: UIResponder, UIApplicationDelegate {
     var mainCoordinator: MainCoordinator?
     lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

     func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         // Override point for customization after application launch.
         mainCoordinator = MainCoordinator(window: window)
         mainCoordinator?.start()
         return true
     }
 }
