//
//  DropboxManager.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 23.02.20.
//  Copyright © 2020 Martin Hochstraßer. All rights reserved.
//

import UIKit
import SwiftyDropbox
import RealmSwift

extension Notification.Name {
    static let dropboxDidAuthorize = Notification.Name("dropboxDidAuthorize")
    static let dropboxError = Notification.Name("dropboxError")
    static let dropboxUserCanceled = Notification.Name("dropboxUserCanceled")
    static let dropboxProgress = Notification.Name("dropboxProgress")
}

public class DropboxManager {
    
    let apiKey = "1to9ek11ppqwdqg"
    
    static let shared = DropboxManager()
    
    func initialize() {
        DropboxClientsManager.setupWithAppKey(apiKey)
    }
    
    func handleRedirect(url: URL) {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
                NotificationCenter.default.post(name: .dropboxDidAuthorize, object: nil)
            case .cancel:
                NotificationCenter.default.post(name: .dropboxUserCanceled, object: nil)
                print("Dropbox Authorization flow was manually canceled by user!")
            case .error(_, let description):
                NotificationCenter.default.post(name: .dropboxError, object: [ "error": description ])
                let alert = UIAlertController(title: "Dropbox", message: description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }

    func authorize(from ctrl: UIViewController) {
        DropboxClientsManager.authorizeFromController(
            UIApplication.shared, controller: ctrl,
            openURL: { (url: URL) -> Void in
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
    }
    
    func upload() {
        
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
                    NotificationCenter.default.post(name: .dropboxProgress, object: ["completed": progressData.fractionCompleted])
                    print(progressData)
                }
        }
    }

}
