//
//  Business_Extension.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/3/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import YelpHelper

extension Business {

    // generate details string
    func getDetails() -> String {
        var detailString = ""
        if !categories.isEmpty {
            detailString = " • \(categories[0].title)"
        }
        if let price = price {
            detailString = "\(price)\(detailString)"
        }
        return detailString
    }
    
    
}
