//
//  MapInterfaceController.swift
//  Watch_WaffleHouseSearch WatchKit Extension
//
//  Created by dirtbag on 1/3/20.
//  Copyright © 2020 dirtbag. All rights reserved.
//

import UIKit
import WatchKit
import MapKit
import YelpHelper

class MapInterfaceController: WKInterfaceController {
    
    
    @IBOutlet weak var mkMap: WKInterfaceMap!
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let business = context as? Business else { return }
        
        let center = CLLocationCoordinate2D(
            latitude: business.coordinates.latitude,
            longitude: business.coordinates.longitude)
        let areaSpan = MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05)
        let areaRegion = MKCoordinateRegion(center: center, span: areaSpan)


        mkMap.setRegion(areaRegion)
        mkMap.addAnnotation(center, with: .red)

 
    }

}
