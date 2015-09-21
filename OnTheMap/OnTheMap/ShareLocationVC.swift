//
//  ShareLocationVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class ShareLocationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var urlStringTextField: UITextField!
    @IBOutlet weak var submitUrlButton: UIButton!
    
    var editingOldLocaion = false
    var locationString = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var urlString = ""
    var oldLocation: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlStringTextField.delegate = self
        
        print("editing old location  \(editingOldLocaion)")
        
        //Looks for single or multiple taps to dismiss keyboard:
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    // move from textfield to another when tapping return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if urlStringTextField.text!.rangeOfString(".") == nil {
            presentMessage(self, title: "Invalid URL", message: "\(urlStringTextField.text!) is Not A Valid URL", action: "Try Again")
        } else {
            self.urlString = urlStringTextField.text!
            DismissKeyboard()
            submitButtonTapped(submitUrlButton)
        }
        return true
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        
//        if editingOldLocaion {
//           Parse.updateStudentLocation(<#T##old: StudentLocation##StudentLocation#>, new: <#T##StudentLocation#>, didComplete: <#T##(success: Bool, status: String?) -> Void#>)
//        } else {
//            Parse.addLocation(<#T##user: StudentLocation##StudentLocation#>, didComplete: <#T##(success: Bool, status: String?) -> Void#>)
//        }
//        
//        
    }
    
    //MARK: DismissKeyboard method:
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}
