//
//  AppDelegate.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 06/07/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import UIKit
import Firebase

let wooColor = UIColor(red: 238/255, green: 68/255, blue: 128/255, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        application.registerForRemoteNotifications()
        application.registerUserNotificationSettings(notificationSettings)
        application.statusBarStyle = .LightContent
        return true
    }



}

