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
        webspinner.stopAnimating()
        presentMessage(self, title: "Error", message: "\(error!.localizedDescription)", action: "OK")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webspinner.stopAnimating()
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openInSafariButtonTapped(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(self.url!)
    }
    
}
