//
//  LookForViewController.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreStore
import SwiftyJSON
import SwiftLocation
import BubbleTransition

class LookForViewController: ExploreBaseViewController {

    @IBOutlet weak var lookForTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLocationTextField: UITextField!
    @IBOutlet weak var lookForTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var listeners = [SuperUser]()
    var consultants = [SuperUser]()
    var selectedSuperUser: SuperUser!
    
    let interactiveTransition = BubbleInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        self.currentLocationTextField.setLeftPaddingPoints(5)
        self.lookForTextField.setLeftPaddingPoints(5)
        fetchSuperUser()
    }
    
    func fetchSuperUser() {
        Database.database().reference().child("super-users").observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let value = snapshot.value {
                let jsons = JSON(value)
                print(jsons)
                self.saveSuperUsers(jsons: jsons)
            }
        }, withCancel: {
            error in
            print(error.localizedDescription)
        })
    }
    
    func saveSuperUsers(jsons: JSON) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From(SuperUser.self))
                for json in jsons.dictionaryValue {
                    let superUser = transaction.create(Into<SuperUser>())
                    superUser.fromJSON(json.value)
                }
        })
        if let listeners = Static.youStack.fetchAll(From<SuperUser>().where(\.role == "LISTENER")) {
            self.listeners = listeners
        }
        if let consultants = Static.youStack.fetchAll(From<SuperUser>().where(\.role == "CONSULTANT")) {
            self.consultants = consultants
        }
        self.lookForTableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LookForDetailViewController {
            if let destinationVC = segue.destination as? LookForDetailViewController {
                destinationVC.superUser = self.selectedSuperUser
            }
        }
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
        if section == 0 {
            return self.listeners.count
        }
        return self.consultants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ListenerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "listenerCell") as! ListenerTableViewCell
            let superUser = self.listeners[indexPath.row]
            cell.updateView(superUser: superUser)
            return cell
        } else {
            let cell: ConsultantTableViewCell = tableView.dequeueReusableCell(withIdentifier: "consultantCell") as! ConsultantTableViewCell
            let superUser = self.consultants[indexPath.row]
            cell.updateView(superUser: superUser)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectedSuperUser = self.listeners[indexPath.row]
        } else {
            self.selectedSuperUser = self.consultants[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
