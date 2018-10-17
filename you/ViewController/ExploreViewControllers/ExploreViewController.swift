//
//  ExploreViewController.swift
//  you
//
//  Created by Jun Zhou on 10/16/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import MapKit
import SwiftLocation

class ExploreViewController: UIViewController {

    @IBOutlet weak var exploreMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Locator.currentPosition(accuracy: .house, onSuccess: {
            location in
            self.exploreMapView.setCenter(location.coordinate, animated: true)
            let distance: CLLocationDistance = 0.2
            var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                                   latitudinalMeters: distance,
                                                                   longitudinalMeters: distance)
            let degree: CLLocationDegrees = 0.2
            mapRegion.span = MKCoordinateSpan(latitudeDelta: degree, longitudeDelta: degree)
            self.exploreMapView.setRegion(mapRegion, animated: true)
            print("Location found: \(location)")
            
        }, onFail: {
            error, last in
            print("Failed to get location: \(error)")
        })
    }


}
