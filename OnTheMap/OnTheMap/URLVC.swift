//
//  URLVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit

class URLVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webspinner: UIActivityIndicatorView!
    
    var urlString = ""
    var fixedUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        // check if there is no http:// in the URL and correct it
        if !urlString.lowercaseString.hasPrefix("http") {
            fixedUrlString = "http://" + urlString
        } else {
            fixedUrlString = urlString
        }
        print(fixedUrlString)
        
        if let url = NSURL (string:fixedUrlString) {
            webspinner.startAnimating()
            webView.bounds.size = self.view.bounds.size
            webView.loadRequest(NSURLRequest(URL: url))
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                presentMessage(self, title: "No Valid Link", message: "\(self.urlString) is not a vaild link!", action: "OK")
            })
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webspinner.stopAnimating()
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openInSafariButtonTapped(sender: UIBarButtonItem) {
        
        if let url = NSURL (string:fixedUrlString) {
            UIApplication.sharedApplication().openURL(url)
        }  else {
            dispatch_async(dispatch_get_main_queue(), {
                presentMessage(self, title: "No Valid Link", message: "\(self.urlString) is not a vaild link!", action: "OK")
            })
        }
    }
}
