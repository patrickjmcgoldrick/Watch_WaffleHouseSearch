//
//  DetailInterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/1/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import WatchKit
import Foundation
import YelpHelper

class DetailInterfaceController: WKInterfaceController {

    @IBOutlet weak var image: WKInterfaceImage!
    
    @IBOutlet weak var lblName: WKInterfaceLabel!
    
    @IBOutlet weak var star0: WKInterfaceImage!
    
    @IBOutlet weak var star1: WKInterfaceImage!
    
    @IBOutlet weak var star2: WKInterfaceImage!
    
    @IBOutlet weak var star3: WKInterfaceImage!
    
    @IBOutlet weak var star4: WKInterfaceImage!
    
    @IBOutlet weak var lblDetails: WKInterfaceLabel!
        
    @IBOutlet weak var lblIsOpenStatus: WKInterfaceLabel!
    
    @IBOutlet weak var lblHours: WKInterfaceLabel!
    
    var business: Business?
    var details: DetailData?
    var stars = [WKInterfaceImage]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        stars = [star0, star1, star2, star3, star4]
        
        guard let receivedBusiness = context as? Business else { return }
        business = receivedBusiness
        
        if let url = business?.image_url {
            image.downloadImageFrom(link: url)
        }
        lblName.setText(business?.name)
        lblDetails.setText(business?.getDetails())
        
        if let rating = business?.rating {
            let intRating = Int(rating)
            for index in 0..<5 {
                if index > intRating {
                    stars[index].setHidden(true)
                } else {
                    stars[index].setHidden(false)
                }
            }
        }
        
        loadDetails()
    }

    @IBAction func actionSwipe(_ sender: Any) {
        
        pushController(withName: "MapController", context: business)
        
    }
    
    private func loadDetails() {
        if let id = business?.id {

            let searcher = YelpSearcher(apiKey: YelpAPI.authorizationKey)
            searcher.readDetails(id: id) { (detailData) in
                self.details = detailData

                DispatchQueue.main.async {
                    guard let details = self.details else { return }
                    self.lblIsOpenStatus.setText(details.isOpenStatus())
                    self.lblHours.setText("  \(details.todaysHours())")
                }
            }
        }
    }
}
