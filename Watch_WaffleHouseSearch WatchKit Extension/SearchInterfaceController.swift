//
//  SearchInterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/3/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WatchKit

class SearchInterfaceController: WKInterfaceController {
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func actionSearch(_ value: NSString?) {
        guard let searchText = value else { return }
        
        pushController(withName: "TableController", context: searchText)
    }
}
