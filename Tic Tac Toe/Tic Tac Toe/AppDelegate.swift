//
//  AppDelegate.swift
//  Tic Tac Toe
//
//  Created by Alexander Peter Maliyakkal on 05/09/24.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create and set up the splash screen view controller
        let splashScreenViewController = SplashScreenViewController()
        window?.rootViewController = splashScreenViewController
        
        window?.makeKeyAndVisible()
        
        // Transition to the WelcomeViewController after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Adjust the delay as needed
            let welcomeViewController = WelcomeViewController()
            let navigationController = UINavigationController(rootViewController: welcomeViewController)
            self.window?.rootViewController = navigationController
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Release shared resources, save user data, invalidate timers, and store application state information.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused or not yet started while the application was inactive.
    }
}
