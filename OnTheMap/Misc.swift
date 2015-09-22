//
//  Misc.swift
//  OnTheMap
//
//  Created by Omar Albeik on 21/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()

//MARK: Present a message helper method:
func presentMessage(view: UIViewController, title: String, message: String, action: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: nil))
    view.presentViewController(alert, animated: true, completion: nil)
}