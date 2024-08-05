//
//  AppDelegate.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        if !UserDefaults.standard.bool(forKey: "formFulled") {
            let rootForm = UserInfoFormViewController(nibName: "UserInfoFormViewController", bundle: .main)
            window?.rootViewController = UINavigationController(rootViewController: rootForm)
            window?.makeKeyAndVisible()
        } else {
            let rootHomeController =  HomeMoviesViewController(nibName: "HomeMoviesViewController", bundle: .main)
            rootHomeController.setupViewModel(viewModel: HomeMovieViewModel())
            window?.rootViewController = UINavigationController(rootViewController: rootHomeController)
            window?.makeKeyAndVisible()
        }
        return true
    }
}

