//
//  LookForViewController.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import MapKit
import SwiftLocation
import BubbleTransition

class LookForViewController: ExploreBaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLocationTextField: UITextField!
    @IBOutlet weak var lookForTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let interactiveTransition = BubbleInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        self.currentLocationTextField.setLeftPaddingPoints(5)
        self.lookForTextField.setLeftPaddingPoints(5)
    }
    
    func getCurrentLocation() {
        Locator.currentPosition(accuracy: .neighborhood, onSuccess: {
            location in
            Locator.location(fromCoordinates: location.coordinate, locale: nil, using: .apple, timeout: nil, onSuccess: {
                places in
                if let place = places.first, let city = place.city, let state = place.administrativeArea {
                    let address = "\(place), \(city), \(state)"
                    self.currentLocationTextField.text = address
                }
            }, onFail: {
                error in
                print(error)
            })
        }, onFail: {
            error, last in
            print("Failed to get location: \(error)")
        })
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LookForViewController: UIViewControllerTransitioningDelegate {
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}

extension LookForViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ListenerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listenerCell") as! ListenerTableViewCell
            return cell
        } else {
            let cell: ConsultantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "consultantCell") as! ConsultantTableViewCell
            return cell
        }
    }
    
    
}
