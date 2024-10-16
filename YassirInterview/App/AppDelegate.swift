//
//  AppDelegate.swift
//  YassirInterview
//
//  Created by Abdelahad on 14/10/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = {
        return UIWindow(frame: UIScreen.main.bounds)
    }()
    
    private lazy var appFlow: AppFlow = {
        return AppFlow.shared
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let window = window {
            appFlow.startFlow(window: window)
        }
        return true
    }
}

