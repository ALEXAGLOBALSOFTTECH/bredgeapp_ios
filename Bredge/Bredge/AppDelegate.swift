//
//  AppDelegate.swift
//  Bredge
//
//  Created by suryaween on 06/09/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAbQ4QlJvZso298hrgExxzGNGKBQpOWWOA")
        GMSPlacesClient.provideAPIKey("AIzaSyAbQ4QlJvZso298hrgExxzGNGKBQpOWWOA")
        IQKeyboardManager.shared.enable = true
        UINavigationBar.appearance().isHidden = true
                
        /*if UserDefaultHelper.isLoggedIn {
            showHome()
        } else {
            showSplash()
        }*/
        
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

extension AppDelegate {
    
    func showSplash() {
        
        let viewController = BRSplashVC()
        let navigation = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigation // Your initial view controller.
        self.window?.makeKeyAndVisible()
    }
    
    func showHome() {
        window?.rootViewController = DashboardController.loadController()
        window?.makeKeyAndVisible()
    }
}
