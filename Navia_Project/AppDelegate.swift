//
//  AppDelegate.swift
//  Navia_Project
//
//  Created by Arinjay on 26/07/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            
            if !accepted {
                print("Notification access denied.")
            }
        }
        

        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        print(notificationSettings.types)
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification){
        
        let alert = UIAlertController(title: "Avantari Task", message: notification.alertBody, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        
        
        let state = application.applicationState
        if state == .active  {
            var window = UIWindow()
            window = UIWindow(frame: UIScreen.main.bounds)
            
            window.rootViewController = UIViewController()
            window.windowLevel = UIWindowLevelAlert + 1
            window.makeKeyAndVisible()
            window.rootViewController?.present(alert, animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: self)
            application.applicationIconBadgeNumber = 0
        }
        
    }
    
    


}

