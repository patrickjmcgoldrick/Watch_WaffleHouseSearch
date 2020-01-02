//
//  InterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/1/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func tappedRestaurant(_ sender: Any) {
        
        pushController(withName: "TableController", context: "restaurant")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
