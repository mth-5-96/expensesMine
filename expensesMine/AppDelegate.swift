//
//  AppDelegate.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 15.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let url = Realm.Configuration().fileURL {
            print(url)
        }
        
        Provisioning.prefillCategories()
        Styler.applyStyle()
        
        return true
    }
}

