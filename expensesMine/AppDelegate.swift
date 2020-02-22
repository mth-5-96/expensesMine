//
//  AppDelegate.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 15.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let url = Realm.Configuration().fileURL {
            print(url)
        }
        
        Provisioning.prefillCategories()
        Styler.applyStyle()
        
        DropboxClientsManager.setupWithAppKey("1to9ek11ppqwdqg")
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
                testDropbox()
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        return true
    }
    
    func testDropbox() {
        
        var qif = ""
        if let realm = try? Realm() {
            let entries = realm.objects(AccountingEntry.self)
            for entry in entries {
                qif = qif + entry.toQifEntry()
            }
        }
        
        if let fileData = qif.data(using: .isoLatin1, allowLossyConversion: false),
            let client = DropboxClientsManager.authorizedClient {
            client.files.upload(path: "/expensesMine.qif", input: fileData)
                .response { response, error in
                    if let response = response {
                        print(response)
                    } else if let error = error {
                        print(error)
                    }
                }
                .progress { progressData in
                    print(progressData)
                }
        }
    }
}

