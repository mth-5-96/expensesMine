//
//  Models.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 21.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import RealmSwift
import FontAwesome

class Category : Object {
    
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var name = ""
    
    @objc dynamic var lastAccessed = Date()
    
    @objc dynamic var accountName = ""
    
    @objc dynamic var icon = FontAwesome.questionCircle.rawValue
    
    override class func primaryKey() -> String {
        return "id"
    }
}

class AccountingEntry : Object {
    
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var amount : Double = 0.0
    
    @objc dynamic var date = Date()
    
    @objc dynamic var note = ""
    
    @objc dynamic var type = "EXPENSE" // or "WITHDRAWAL" or "OPENINGBALANCE"
    
    @objc dynamic var category : Category?
    
    override class func primaryKey() -> String {
        return "id"
    }
}
