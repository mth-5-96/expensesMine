//
//  Provisioning.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 06.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import Foundation
import RealmSwift


class Provisioning {
    
    class func prefillCategories() {
        
        do {
            if let jsonUrl = Bundle.main.url(forResource: "accounts", withExtension: "json") {
                let data = try Data(contentsOf: jsonUrl)
                let categories = try JSONDecoder().decode([Category].self, from: data)
                let realm = try Realm()
                if realm.objects(Category.self).count == 0 {
                    do {
                        try realm.write {
                            for category in categories {
                                realm.create(Category.self, value: category, update: .all)
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }                
            }
        } catch {
            print(error)
        }
    }
    
}
