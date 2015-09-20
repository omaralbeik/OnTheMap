//
//  SignUpVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webspinner: UIActivityIndicatorView!
    
    let url = NSURL (string: "https://www.udacity.com/account/auth#!/signup")

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        webspinner.startAnimating()
        webView.bounds.size = self.view.bounds.size
        webView.loadRequest(NSURLRequest(URL: url!))
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.webspinner.stopAnimating()
        
        let alert = UIAlertController(title: "No Internet!", message: "Can not Connect to The Inernet, Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.webView.loadRequest(NSURLRequest(URL: self.url!))
                
            case .Cancel:
                self.webView.loadRequest(NSURLRequest(URL: self.url!))
                
            case .Destructive:
                self.webView.loadRequest(NSURLRequest(URL: self.url!))
                
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openInSafariButtonTapped(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(self.url!)
    }



}
