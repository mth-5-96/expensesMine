//
//  SettingsViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 15.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form = Section("Settings")
            +++ DecimalRow("amount") { row in
                    row.title = "Startguthaben"
                    row.placeholder = "0.0"
                }
            +++ ButtonRow("upload") { row in
                row.title = "Upload to Dropbox"
                row.presentationMode = .show(controllerProvider: .storyBoard(storyboardId: "UploadVC", storyboardName: "Main", bundle: Bundle.main), onDismiss: nil)
            }
    }
}

