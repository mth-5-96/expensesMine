//
//  Models.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 21.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import RealmSwift
import FontAwesome_swift

class Category : Object {
    
    dynamic var id = UUID().uuidString
    
    dynamic var name = ""
    
    dynamic var lastAccessed = Date()
    
    dynamic var accountName = ""
    
    dynamic var icon = FontAwesome.questionCircle.rawValue
    
    override class func primaryKey() -> String {
        return "id"
    }
}

class AccountingEntry : Object {
    
    dynamic var id = UUID().uuidString
    
    dynamic var amount : Double = 0.0
    
    dynamic var date = Date()
    
    dynamic var note = ""
    
    dynamic var type = "EXPENSE" // or "WITHDRAWAL" or "OPENINGBALANCE"
    
    dynamic var category : Category?
    
    override class func primaryKey() -> String {
        return "id"
    }
}
