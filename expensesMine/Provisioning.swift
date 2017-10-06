//
//  Provisioning.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 06.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import Foundation
import RealmSwift

let categories = [
    ["name": "Unterhaltung", "accountName": "Aufwendungen:Unterhaltung:Ausgehen"],
    ["name": "Benzin", "accountName": "Aufwendungen:Fahrtkosten:Auto:Benzin"],
    ["name": "Lebensmittel", "accountName": "Aufwendungen:Lebensmittel"],
    ["name": "Auswärts essen beruflich", "accountName": "Aufwendungen:Lebensmittel:Auswärts essen beruflich"],
    ["name": "Kleidung", "accountName": "Aufwendungen:Kleidung"],
    ["name": "Lieferservice", "accountName": "Aufwendungen:Lebensmittel:Lieferservice"],
    ["name": "Körperpflege", "accountName": "Aufwendungen:Körperpflege"],
    ["name": "Geschenke", "accountName": "Aufwendungen:Geschenke:Esther"],
    ["name": "Fahrkarten", "accountName": "Aufwendungen:Fahrtkosten:Fahrkarten"],
    ["name": "Parkgebühren", "accountName": "Aufwendungen:Fahrtkosten:Auto:Parkgebühren"]
]

class Provisioning {
    
    class func prefillCategories() {
        
        if let realm = try? Realm() {
            if realm.objects(Category.self).count == 0 {
                do {
                    try realm.write {
                        realm.create(Category.self, value: categories, update: false)
                    }
                }
                catch {
                    print(error)
                }
            }
        }
    }
    
}
