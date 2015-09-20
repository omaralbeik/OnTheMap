//
//  ListVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocation.locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath)
        let name = StudentLocation.locations[indexPath.row].firstName! + " " + StudentLocation.locations[indexPath.row].lastName!
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = StudentLocation.locations[indexPath.row].mapString!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "fromListToURLVCSegue" {
            let urlVC = segue.destinationViewController as! URLVC
            urlVC.urlString = StudentLocation.locations[(tableView.indexPathForSelectedRow?.row)!].mediaURL!
            
        }
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
        updateLocations()
    }
    
    func updateLocations() {
        
        self.tableView.alpha = 0.3
        
        Parse.getLocations { (success, status, locationsArray) -> Void in
            if success {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    
                    StudentLocation.locations = locationsArray!
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.alpha = 1
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
