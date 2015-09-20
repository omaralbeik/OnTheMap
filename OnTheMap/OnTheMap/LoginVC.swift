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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
    }
    
    @IBAction func signUpButtonTapped(sender: UIButton) {
        
    }
    
}
