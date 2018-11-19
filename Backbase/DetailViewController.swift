//
//  DetailViewController.swift
//  Backbase
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var lat: Double = 0
    var lon: Double = 0
    var city: String = ""
    var country: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openMapForPlace()
    }
    
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lon
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = city + "," + country
        mapItem.openInMaps(launchOptions: options)
    }
}

