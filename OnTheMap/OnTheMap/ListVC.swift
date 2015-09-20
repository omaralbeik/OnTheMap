//
//  ListVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logOutButtonTapped(sender: UIBarButtonItem) {

    }
    
    @IBAction func addLocationButtonTapped(sender: UIBarButtonItem) {
        performSegueWithIdentifier("addFromListSegue", sender: self)
    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
    }

}
