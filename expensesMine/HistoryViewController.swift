//
//  HistoryViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 06.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController : UITableViewController {
    
    var startDate = Date().startOfMonth()
    var endDate = Date().endOfMonth()
    
    var items = [[AccountingEntry]]()
    var headers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items.removeAll()
        
        do {
            let realm = try Realm()
            let entries = realm.objects(AccountingEntry.self).filter("date BETWEEN {%@, %@}", startDate, endDate)
            items.append([])
            items[0].append(contentsOf: entries)
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[0].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryEntryCell
        let entry = items[0][indexPath.row]
        cell.amountLabel.text = String(format: "%3.2f €", entry.amount)
        cell.amountLabel.textColor = entry.amount < 0 ? UIColor.red : UIColor.green
        cell.categoryLabel.text = entry.category?.name
        cell.noteLabel.text = entry.note
        return cell
    }
    
    func handleAdd(_ sender: AnyObject?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntryEditVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
