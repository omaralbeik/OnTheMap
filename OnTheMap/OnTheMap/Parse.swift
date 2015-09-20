//
//  Parse.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import Foundation

class Parse {
    
    class func getLocations(didComplete: (success: Bool, status: String?, locationsArray: [StudentLocation]?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.ParseBaseLink + ParseMethodNames.StudentLocation + "?limit=\(Constants.ResultsLimit)")!)
        request.addValue(Constants.ParseApplicationID, forHTTPHeaderField: ParseHTTPHeaders.ParseApplicationID)
        request.addValue(Constants.RESTAPIKey, forHTTPHeaderField: ParseHTTPHeaders.RESTAPIKey)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                didComplete(success: false, status: "Network Error Occurred", locationsArray: nil)
                return
            }
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                guard let results = parsedResult["results"] as? [[String : AnyObject]] else {
                    print("Can't find results in \(parsedResult!)")
                    didComplete(success: false, status: "Couldn't find Results", locationsArray: nil)
                    return
                }
                let locations = StudentLocation.locationsFromResults(results)
                didComplete(success: true, status: nil, locationsArray: locations)
                
            } catch {
                parsedResult = nil
                print("Could not parse the data as JSON: '\(data)'")
                didComplete(success: false, status: "Couldn't find Results", locationsArray: nil)
                return
            }
        }
        task.resume()
    }
    
}