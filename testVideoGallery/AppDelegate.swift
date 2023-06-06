//
//  AppDelegate.swift
//  testVideoGallery
//
//  Created by pcg on 2023/6/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewController:VideoGalleryViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            print("above 13, skip didFinishLaunchingWithOptions")
        } else {
            viewController = VideoGalleryViewController();
            if let viewController = viewController {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.backgroundColor = .white
                let navigation = UINavigationController(rootViewController: viewController)
                self.window?.rootViewController = navigation
                self.window?.makeKeyAndVisible()
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

