//
//  Styler.swift
//  expensesMine
//
//  Created by Martin Hochstraßer on 30.10.17.
//  Copyright © 2017 Martin Hochstraßer. All rights reserved.
//

import UIKit

public class Styler {
    
    static var RED    = UIColor(red: 0xD3/0xFF, green: 0x3F/0xFF, blue: 0x34/0xFF, alpha: 1.0)
    static var GREEN  = UIColor(red: 0x73/0xFF, green: 0xAF/0xFF, blue: 0x57/0xFF, alpha: 1.0)
    static var WHITE  = UIColor(red: 0xEC/0xFF, green: 0xE4/0xFF, blue: 0xB7/0xFF, alpha: 1.0)
    static var YELLOW = UIColor(red: 0xE5/0xFF, green: 0xBB/0xFF, blue: 0x49/0xFF, alpha: 1.0)
    static var GRAY   = UIColor(red: 0x47/0xFF, green: 0x47/0xFF, blue: 0x47/0xFF, alpha: 1.0)
    
    
    class func applyStyle() {
        
        UITableView.appearance(whenContainedInInstancesOf: [HistoryViewController.self]).backgroundColor = GRAY
        UITableViewCell.appearance(whenContainedInInstancesOf: [HistoryViewController.self]).backgroundColor = GRAY
        
    }
    
}
