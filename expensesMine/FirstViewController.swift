//
//  FirstViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 15.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import Eureka

class FirstViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Neue Buchung"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(handleDone(sender:)))
        
        form = Section("accountingentry")
            +++ TextAreaRow("note") { row in
                row.title = "Notiz"
                row.placeholder = "Notiz"
            }
            <<< DecimalRow("amount") { row in
                row.title = "Betrag"
                row.placeholder = "Betrag"
            }
            <<< DateInlineRow("date") { row in
                row.title = "Datum"
                row.value = Date()
        }
    }
    
    func handleDone(sender: AnyObject?) {
        let values = form.values()
        print("\(values)")
    }

}

