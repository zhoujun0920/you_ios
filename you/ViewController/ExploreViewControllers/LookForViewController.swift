//
//  LookForViewController.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import MapKit
import BubbleTransition

class LookForViewController: ExploreBaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLocationTextField: UITextField!
    @IBOutlet weak var lookForTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    let interactiveTransition = BubbleInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentLocationTextField.setLeftPaddingPoints(5)
        self.lookForTextField.setLeftPaddingPoints(5)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 5))
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        return cell
    }
    
    
}
