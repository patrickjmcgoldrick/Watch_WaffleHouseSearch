//
//  TableInterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/1/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import WatchKit
import YelpHelper
import Foundation

class TableInterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var searchText: String?
    var businessesFound = [Business]()
    var searchCoordinates = Coordinates(latitude: 33.9202195, longitude: -84.5348863)
    let yelpSearcher = YelpSearcher(apiKey: YelpAPI.authorizationKey)
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let searchText = context as? String else { return }
        self.searchText = searchText
        
        loadYelpData()
    }

    func loadYelpData() {
        
        guard let searchText = searchText else { return }
        
        let url = yelpSearcher.createURL(
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
                self.table.setNumberOfRows(self.businessesFound.count, withRowType: "RowCell")

                
                for index in 0..<self.businessesFound.count {
                    let business = self.businessesFound[index]
                    let row = self.table.rowController(at: index) as? TableRowCell
                    row?.lblName.setText(business.name)
                    
                    // Details
                    row?.lblDetails.setText(business.getDetails())
                    
                    // distance
                    if let distance = business.distance { row?.lblDistance.setText(business.toMiles(meters: distance))
                    }
                    
                    // image
                    if let url = business.image_url {
                        row?.image.downloadImageFrom(link: url)
                    }
                }
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        pushController(withName: "DetailController", context: businessesFound[rowIndex])
    }
}
