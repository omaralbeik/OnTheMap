//
//  Udacity.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import Foundation

class Udacity {
    
    class func logIn(username: String, password: String, didComplete: (success: Bool, status: String?, userID: String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.UdacityBaseLink + "session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            guard (error == nil) else {
                didComplete(success: false, status: "Network Error Occurred", userID: nil)
                return
            }
            
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                
                guard let account = parsedResult["account"] as? NSDictionary else {
                    didComplete(success: false, status: parsedResult["error"]! as? String, userID: nil)
                    return
                }
                
                let userID = account["key"] as? String
                didComplete(success: true, status: nil, userID: userID)
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "userID")
                
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                didComplete(success: false, status: "Network Error Occurred", userID: nil)
                return
            }
        }
        task.resume()
    }
    
    
}