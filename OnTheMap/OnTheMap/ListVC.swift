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
        tableView.alpha = 0.3
        logOutButton.enabled = false
        Udacity.logout { (success, status) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.alpha = 1.0
                    self.logOutButton.enabled = true
                })
            }
        }
    }
    
    @IBAction func addLocationButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
    }

}
