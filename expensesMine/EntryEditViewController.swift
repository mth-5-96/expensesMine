//
//  FirstViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 15.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class EntryEditViewController: FormViewController {

    var entry : AccountingEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var categories : [Category] = []
        do {
            let realm = try Realm()
            categories = Array(realm.objects(Category.self))
        } catch {
            print(error)
        }
        
        navigationItem.title = "Neue Buchung"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(handleDone(sender:)))
        
        form +++ Section(header: "Buchung", footer: "")
            <<< TextAreaRow("note") { row in
                row.title = "Notiz"
                row.placeholder = "Notiz"
                row.value = entry?.note
            }
            <<< DecimalRow("amount") { row in
                row.title = "Betrag"
                row.placeholder = "Betrag"
                row.value = entry?.amount ?? -0.0
            }
            .cellSetup({ (c,_) in c.textField.keyboardType = .numbersAndPunctuation })
            <<< DateTimeInlineRow("date") { row in
                row.title = "Datum"
                row.value = entry?.date ?? Date()
            }
            <<< PushRow<Category>("category") { row in
                row.title = "Konto"
                row.options = categories
                row.displayValueFor = { $0?.name }
            }
    }
    
    func handleDone(sender: AnyObject?) {
        let values = form.values()
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(AccountingEntry.self, value: values, update: false)
            }
        } catch {
            print(error)
        }
    }

}

