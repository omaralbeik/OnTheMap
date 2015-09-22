//
//  AddLocationVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class AddLocationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var submitLocationButton: UIButton!
    @IBOutlet weak var locationStringTextField: UITextField!
    
    @IBOutlet weak var geoLoactionSpinner: UIActivityIndicatorView!
    
    
    var editingOldLocation = false
    var oldLocation: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set textfield delegate
        locationStringTextField.delegate = self
        
        // set text fields style
        let emailPaddingView = UITextField(frame: CGRectMake(0, 0, 30, 0))
        locationStringTextField.leftView = emailPaddingView
        locationStringTextField.leftViewMode = UITextFieldViewMode.Always
        
        //Looks for single or multiple taps to dismiss keyboard:
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        DismissKeyboard()
        findLocationButtonTapped(submitLocationButton)
        return true
    }
    
    //MARK: findLocationButtonTapped
    @IBAction func findLocationButtonTapped(sender: UIButton) {
        
        geoLoactionSpinner.startAnimating()
        
        if locationStringTextField.text?.isEmpty == true {
            presentMessage(self, title: "No Location", message: "No location, Please enter your location and try again!", action: "OK")
            geoLoactionSpinner.stopAnimating()
        } else {
            performSegueWithIdentifier("toConfirmMapVCSegue", sender: self)
            geoLoactionSpinner.stopAnimating()
        }
    }
    
    //MARK: cancelButtonTapped
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toConfirmMapVCSegue" {
            let confirmLocationVC = segue.destinationViewController as! ConfirmLocationVC
            
            if locationStringTextField.text?.isEmpty == false {
                confirmLocationVC.editingOldLocation = self.editingOldLocation
                confirmLocationVC.locationString = locationStringTextField.text!
                confirmLocationVC.oldLocation = self.oldLocation
            } else {
                presentMessage(self, title: "No Location", message: "No location typed, Please enter your location and try again", action: "OK")
            }
        }
    }
    
    
    //MARK: DismissKeyboard method:
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
