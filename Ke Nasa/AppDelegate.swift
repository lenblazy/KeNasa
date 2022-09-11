//
//  AppDelegate.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        //
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.00)]
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.00)]
        navBarAppearance.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.94)
        //
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        //
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

