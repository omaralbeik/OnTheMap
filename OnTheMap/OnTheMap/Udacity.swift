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
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.UdacityBaseLink + UdacityMethodNames.Session)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            guard (error == nil) else {
                didComplete(success: false, status: error!.localizedDescription, userID: nil)
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
                NSUserDefaults.standardUserDefaults().setObject(userID!, forKey: "userID")
                
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                didComplete(success: false, status: "Network Error Occurred", userID: nil)
                return
            }
        }
        task.resume()
    }
    
    class func logout(didComplete: (success: Bool, status: String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.UdacityBaseLink + UdacityMethodNames.Session)!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! as [NSHTTPCookie] {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard (error == nil) else {
                didComplete(success: false, status: error!.localizedDescription)
                return
            }
            
            didComplete(success: true, status: nil)
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                
                guard let _ = parsedResult["session"] as? NSDictionary else {
                    didComplete(success: false, status: parsedResult["error"]! as? String)
                    return
                }
                didComplete(success: true, status: nil)
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userID")
                
            } catch {
                parsedResult = nil
                didComplete(success: false, status: "Network Error Occurred")
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
        }
        task.resume()
    }
    
    class func getUserInfo(didComplete: (success: Bool, status: String?, userLastName: String?) -> Void) {
        
        if let userId = NSUserDefaults.standardUserDefaults().valueForKey("userID") as? String {
            
            let request = NSMutableURLRequest(URL: NSURL(string: Constants.UdacityBaseLink + UdacityMethodNames.Users + userId)!)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { data, response, error in
                if error != nil { // Handle error...
                    return
                }
                
                guard (error == nil) else {
                    print(error!.localizedDescription)
                    didComplete(success: false, status: error!.localizedDescription, userLastName: nil)
                    return
                }
                
                let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
                let parsedResult: AnyObject!
                
                do {
                    parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                    
                    guard let user = parsedResult["user"] as? NSDictionary else {
                        print("Can't find user in: \(parsedResult)")
                        didComplete(success: false, status: "Network Error Occurred", userLastName: nil)
                        return
                    }
                    
                    if let userLastName = user["last_name"] as? String {
                        didComplete(success: true, status: nil, userLastName: userLastName)
                    }
                    
                } catch {
                    parsedResult = nil
                    print("Could not parse the data as JSON: '\(data)'")
                    didComplete(success: false, status: "Network Error Occurred", userLastName: nil)
                    return
                }
            }
            task.resume()
        }
    }
    
    
}