//
//  Models.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 21.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import RealmSwift

class Category : Object {
    
    dynamic var name = ""
    
    dynamic var lastAccessed = Date()
    
    dynamic var accountName = ""
    
}

class AccountingEntry : Object {
    
    dynamic var amount : Double = 0.0
    
    dynamic var note = ""
    
    dynamic var type = "EXPENSE" // or "WITHDRAWAL" or "OPENINGBALANCE"
    
    dynamic var category : Category?
    
}
