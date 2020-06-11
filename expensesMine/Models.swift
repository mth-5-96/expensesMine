//
//  Models.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 21.09.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import RealmSwift
import FontAwesome

class Category : Object, Codable {
    
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var name = ""
    
    @objc dynamic var type = ""
    
    @objc dynamic var lastAccessed: Date?
    
    @objc dynamic var accountName = ""
    
    @objc dynamic var parentId: String?
    
    @objc dynamic var icon: String? = FontAwesome.questionCircle.rawValue
    
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

extension AccountingEntry {
    func toQifEntry() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        
        let result = """
            D\(format.string(from: date))
            T\(String(format: "%3.2f", amount))
            L\(category!.accountName)
            M\(note)
            ^
            """
        return result
    }
}
