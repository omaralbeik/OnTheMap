//
//  LoginVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    
    var currentKeyboardHeight: CGFloat = 0.0
    var viewMovedUp = false
    var viewMovedDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set text fields delegates
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // set text fields style
        let emailPaddingView = UITextField(frame: CGRectMake(0, 0, 10, 0))
        usernameTextField.leftView = emailPaddingView
        usernameTextField.leftViewMode = UITextFieldViewMode.Always
        let passwordPaddingView = UITextField(frame: CGRectMake(0, 0, 10, 0))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = UITextFieldViewMode.Always
        usernameTextField.tintColor = UIColor.orangeColor()
        passwordTextField.tintColor = UIColor.orangeColor()
        
        //Looks for single or multiple taps to dismiss keyboard:
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    // move from textfield to another when tapping return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if usernameTextField.isFirstResponder() {
            // check if email contains '@' and '.' chracters:
            if (usernameTextField.text!.rangeOfString("@") == nil || usernameTextField.text!.rangeOfString(".") == nil) {
                presentMessage("Invalid Email Address", message: "\(usernameTextField.text!) is Not A Valid Email Address", action: "Try Again")
            } else {
                passwordTextField.becomeFirstResponder()
            }
        } else {
            DismissKeyboard()
            loginButtonTapped(loginButton)
        }
        return true
    }
    
    //MARK: DismissKeyboard method:
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    //MARK: Present a message helper method:
    func presentMessage(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Login
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        // check if username and password textfields are empty
        if usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            presentMessage("No Email and/or Password", message: "Please Enter Your Email and Password", action: "OK")
        }
        else {
            loginButton.hidden = true
            loginSpinner.startAnimating()
                        
            Udacity.logIn(usernameTextField.text!, password: passwordTextField.text!) { (success, status, userID) -> Void in
                
                if success == false {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.loginSpinner.stopAnimating()
                        self.loginButton.hidden = false
                        self.presentMessage("Error", message: status!, action: "OK")
                    })
                    return
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.DismissKeyboard()
                    self.loginSpinner.stopAnimating()
                    self.loginButton.hidden = false
                    // removing password, so when user signs out, he has to enter the password again (for security reasons)
                    self.passwordTextField.text = ""
                    self.performSegueWithIdentifier("toTabVCSegue", sender: self)
                })
            }
            
        }
    }
    
}
