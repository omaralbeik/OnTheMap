//
//  ConfirmLocationVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit
import MapKit

class ConfirmLocationVC: UIViewController {
    
    @IBOutlet weak var locationStringLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitLocationButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
    }

}
