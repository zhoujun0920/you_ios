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
import BubbleTransition

class ExploreViewController: ExploreBaseViewController {

    @IBOutlet weak var exploreMapView: MKMapView!
    @IBOutlet weak var lookForView: UIView!
    @IBOutlet weak var lookForTableView: UITableView!
    
    let transition = BubbleTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                      action: #selector(lookForTapped(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.05
        self.lookForView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    @objc func lookForTapped(_ sender: UITapGestureRecognizer) {
        if (sender.state == UITapGestureRecognizer.State.began) {
            self.lookForView.backgroundColor = UIColor.groupTableViewBackground
        } else if (sender.state == UITapGestureRecognizer.State.ended) {
            self.lookForView.backgroundColor = UIColor.white
            if let lookForViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LookForVC") as? LookForViewController {
                lookForViewController.transitioningDelegate = self
                lookForViewController.modalPresentationStyle = .custom
                self.present(lookForViewController, animated: true, completion: nil)
            }
        }
    }
    
    func getCurrentLocation() {
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

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
}

extension ExploreViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.lookForView.center
        transition.bubbleColor = self.lookForView.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.lookForView.center
        transition.bubbleColor = self.lookForView.backgroundColor!
        return transition
    }
}
