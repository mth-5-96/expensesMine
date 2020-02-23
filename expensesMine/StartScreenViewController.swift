//
//  StartScreenViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 20.08.19.
//  Copyright © 2019 Martin Hochstraßer. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyDropbox

class StartScreenViewController : UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            let realm = try Realm()
            let entries = realm.objects(AccountingEntry.self)
            
            let sum = Array(entries).reduce(0.0) { (sum, entry) -> Double in
                sum + entry.amount
            }
            
            amountLabel.text = "\(String(format: "%3.2f", sum)) €"
        } catch {
            print(error)
        }
    }
}
