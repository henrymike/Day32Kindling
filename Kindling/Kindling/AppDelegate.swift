//
//  AppDelegate.swift
//  Kindling
//
//  Created by Mike Henry on 11/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("HoYViXrIMjAtNMSH8uOhPyJC2VVrjnpWYVqHhQYk",
            clientKey: "GXtx5niJFmuptHPW6gzMw5BLtohMGxaw0tO6BH9F")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        return true
    }

}

