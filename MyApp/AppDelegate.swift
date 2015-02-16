//
//  AppDelegate.swift
//  MyApp
//
//  Created by Luppy on 15/2/15.
//  Copyright (c) 2015 Lee Lup Yuen. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var beaconManager: BeaconManager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize Parse.
        /*
        Enable Crash Reporting
        Remember to add to MyApp -> Build Phases -> Run Script
        
        export PATH=/usr/local/bin:$PATH
        cd ~/Desktop/MyApp/parse
        parse symbols "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
        */
        ParseCrashReporting.enable()
        
        Parse.enableLocalDatastore()
        // Setup Parse.
        Parse.setApplicationId("w0VLKuzlB18EeZUAVnx8lj2WqcrOW9XrCDzOvZb3",
            clientKey: "qPo0opX8uKki3iUYIgxIzfcdbRUSpc4YgAveZ6WF")
        // Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        //  Enable security.
        /*
        PFUser.enableAutomaticUser()
        var defaultACL = PFACL.ACL()
        // Optionally enable public read access while disabling public write access.
        // defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
        */
        
        //  Create a BeaconManager to handle beacons.
        beaconManager = BeaconManager()
        //  Broadcast this device as a beacon.
        beaconManager?.createBeacon()
        //  Listen for other beacons.
        beaconManager?.registerBeacons()
        
        //  Prompt to allow notifications.
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }

        return true
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

