//
//  MapVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var logOutSpinner: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logOutButtonTapped(sender: UIBarButtonItem) {
        mapView.alpha = 0.3
        logOutButton.enabled = false
        logOutSpinner.startAnimating()
        Udacity.logout { (success, status) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.mapView.alpha = 1.0
                    self.logOutButton.enabled = true
                    self.logOutSpinner.stopAnimating()
                })
            }
        }
    }
    
    @IBAction func addLocationButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        
    }
    
}
