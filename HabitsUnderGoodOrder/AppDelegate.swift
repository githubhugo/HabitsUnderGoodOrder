//
//  AppDelegate.swift
//  HabitsUnderGoodOrder
//
//  Created by MAC1 on 30/05/16.
//  Copyright © 2016 BTS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create the Yes and No actions
        let yesAction = UIMutableUserNotificationAction()
        yesAction.identifier = "YesAction"
        // Title of the button in the notification
        yesAction.title = "Yes"
        
        let noAction = UIMutableUserNotificationAction()
        noAction.identifier = "NoAction"
        // Title of the button in the notification
        noAction.title = "No"
        
        // Create a category to register for the Yes/No actions
        let yesNoCategory = UIMutableUserNotificationCategory()
        // Internal identifier for the OS to know which notification actions to show
        yesNoCategory.identifier = "YesNoNotification"
        // Set the actions for this category, and the "Minimal" context is the small notifications at the top
        yesNoCategory.setActions([yesAction, noAction], forContext: .Minimal)
        yesNoCategory.setActions([yesAction, noAction], forContext: .Default)
        
        // Specify which kind of notifications the app will send
        // We want to show alerts, change the app badge (number in the app iocon) and be able to play a sound
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: [yesNoCategory])
        // Register the notifications, this will show the user the alert to accept of deny notifications
        application.registerUserNotificationSettings(notificationSettings)
        
        return true
    }
    
    // This method is called when the buttons in notification are pressed
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification: UILocalNotification, completionHandler: () -> Void) {
        if (identifier == "YesAction") {
            // "Yes" button was pressed
            
        } else {
            // "No" button was pressed
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Clear notifications count on badge icon
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

