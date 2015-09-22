//
//  Constants.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - Base Links
    static let UdacityBaseLink = "https://www.udacity.com/api/"
    static let ParseBaseLink = "https://api.parse.com/1/classes/"
    
    // MARK: - Keys
    static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    static let ParseResultsLimit = 1000
}

struct ParseHTTPHeaders {
    static let ParseApplicationID = "X-Parse-Application-Id"
    static let RESTAPIKey = "X-Parse-REST-API-Key"
}

struct ParseMethodNames {
    static let StudentLocation = "StudentLocation"
}

struct UdacityMethodNames {
    static let Session = "session"
    static let Users = "users/"
}


// MARK: - Parse JSON Body Keys
struct ParseJSONBodyKeys {
    static let UniqueKey = "uniqueKey"
    static let FirstName = "firstName"
    static let LastName = "lastName"
    static let MapString = "mapString"
    static let MediaURL = "mediaURL"
    static let Latitude = "latitude"
    static let Longitude = "longitude"
}