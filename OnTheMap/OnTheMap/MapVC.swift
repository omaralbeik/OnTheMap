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

    }
    
    @IBAction func addLocationButtonTapped(sender: UIBarButtonItem) {

    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {

    }

}
