//
//  HistoryViewController.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 06.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit

class HistoryViewController : UITableViewController {
    
    var startDate = Date().startOfMonth()
    var endDate = Date().endOfMonth()
    
    var items = [[AccountingEntry]]()
    var headers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell")!
    }
    
    func handleAdd(_ sender: AnyObject?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EntryEditVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
