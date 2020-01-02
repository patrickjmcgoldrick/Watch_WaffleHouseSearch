//
//  WKInterfaceImage_Extension.swift
//  Watch_SimpsonsProject WatchKit Extension
//
//  Created by dirtbag on 12/26/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import WatchKit

extension WKInterfaceImage {

    func downloadImageFrom(link:String) {
        //} contentMode: UIView.ContentMode) {
        
        if link.isEmpty {
            self.setImage(UIImage(named: "butters"))
            return
        }
        
        guard let url = URL(string: link) else { return }

        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                //self.contentMode =  contentMode
                if let data = data {
                    self.setImage(UIImage(data: data))
                }
            }
        }).resume()
    }
}
