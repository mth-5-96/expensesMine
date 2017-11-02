//
//  HistoryViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 06.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift


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
            let entries = realm
                .objects(AccountingEntry.self)
                .filter("date BETWEEN {%@, %@}", startDate, endDate)
                .sorted(byKeyPath: "date", ascending: true)
            
            let df = DateFormatter()
            df.dateFormat = "dd.MM.yyyy"
            
            var last = df.string(from:entries[0].date)
            var current = [AccountingEntry]()
            for entry in entries {
                let next = df.string(from: entry.date)
                current.append(entry)
                if next != last {
                    headers.append(last)
                    items.append(current)
                    current = [AccountingEntry]()
                    last = next
                }
            }
            headers.append(last)
            
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryEntryCell
        let entry = items[indexPath.section][indexPath.row]
        
        cell.amountLabel.text = String(format: "%3.2f €", entry.amount)
        cell.amountLabel.textColor = entry.amount < 0 ? Styler.RED : Styler.GREEN
        cell.categoryLabel.text = entry.category?.name
        cell.categoryLabel.textColor = Styler.YELLOW
        cell.noteLabel.text = entry.note
        cell.noteLabel.textColor = Styler.WHITE
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntryEditVC") as! EntryEditViewController
        vc.entry = items[indexPath.section][indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Löschen") { (rowAction, indexPath) in
            self.handleDelete(indexPath)
        }
        return [delete]
    }
    
    func handleDelete(_ indexPath: IndexPath) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(items[indexPath.section][indexPath.row])
                items[indexPath.section].remove(at: indexPath.row)
            }
        } catch {
            print(error)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func handleAdd(_ sender: AnyObject?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntryEditVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
