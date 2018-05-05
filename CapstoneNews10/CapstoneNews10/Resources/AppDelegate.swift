//
//  AppDelegate.swift
//  CapstoneNews10
//
//  Created by Jatin Menghani on 08/10/17.
//  Copyright © 2017 Jatin Menghani. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: authOptions, completionHandler: { (_, _) in
                Messaging.messaging().delegate = self
            })
        }
        else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        var sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "countryCV")
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "countrySelected") {
            sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loadingVC")
        }
        
        window?.rootViewController = sb
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("hello")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.sound)
    }
}

