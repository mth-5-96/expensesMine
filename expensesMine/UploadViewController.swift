//
//  UploadViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 23.02.20.
//  Copyright © 2020 Martin Hochstraßer. All rights reserved.
//

import UIKit

class UploadViewController : UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func upload(_ sender: Any) {
        DropboxManager.shared.authorize(from: self)
    }
}
