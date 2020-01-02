//
//  TableInterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/1/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import WatchKit
import Foundation

class TableInterfaceController: WKInterfaceController {

    var searchText: String?
    var businessesFound = [Business]()
    var searchCoordinates = Coordinates(latitude: 33.9202195, longitude: -84.5348863)
    let yelpSearcher = YelpSearcher()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let searchText = context as? String else { return }
        self.searchText = searchText
        
        loadYelpData()
    }

    func loadYelpData() {
        
        guard let searchText = searchText else { return }
        
        var url = yelpSearcher.createURL(
            searchTerm: searchText,
            latitude: searchCoordinates.latitude,
            longitude: searchCoordinates.longitude)

        guard let unrappedURL = url else { return }

        searchYelp(url: unrappedURL)
    }
    
    private func searchYelp(url: URL) {

        yelpSearcher.readPointsFromYelp(url: url) { (searchData) in

            guard let businesses = searchData.businesses else { return }

            self.businessesFound = businesses
            self.searchCoordinates = searchData.region.center

            DispatchQueue.main.async {
                for business in businesses {
                    print(business.name)
                }
                //self.tableView.reloadData()
            }
        }

    }
}
