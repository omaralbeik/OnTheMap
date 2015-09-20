//
//  MapVC.swift
//  OnTheMap
//
//  Created by Omar Albeik on 20/09/15.
//  Copyright © 2015 Omar Albeik. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var logOutSpinner: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addAnnotations()
    }
    
    func addAnnotations() {
        
        self.mapView.alpha = 0.3
        self.logOutSpinner.startAnimating()
        
        Parse.getLocations { (success, status, locationsArray) -> Void in
            if success {
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    
                    StudentLocation.locations = locationsArray!
                    
                    for location in StudentLocation.locations {
                        
                        // Notice that the float values are being used to create CLLocationDegree values.
                        // This is a version of the Double type.
                        let lat = CLLocationDegrees(location.latitude!)
                        let long = CLLocationDegrees(location.longitude!)
                        
                        // The lat and long are used to create a CLLocationCoordinates2D instance.
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        
                        let first = location.firstName!
                        let last = location.lastName!
                        let mediaURL = location.mediaURL!
                        
                        // Here we create the annotation and set its coordiate, title, and subtitle properties
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(first) \(last)"
                        annotation.subtitle = mediaURL
                        
                        // Finally we place the annotation in an array of annotations.
                        self.annotations.append(annotation)
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.mapView.alpha = 1
                        self.logOutSpinner.stopAnimating()
                        self.mapView.addAnnotations(self.annotations)

                        
                    }
                }

            }
        }
        
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.orangeColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            pinView!.animatesDrop = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == annotationView.rightCalloutAccessoryView {
            performSegueWithIdentifier("fromMapToURLVCSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fromMapToURLVCSegue" {
            let urlVC = segue.destinationViewController as! URLVC
            urlVC.urlString = (mapView.selectedAnnotations.first?.subtitle!)!
        }
    }
    
    @IBAction func logOutButtonTapped(sender: UIBarButtonItem) {
        mapView.alpha = 0.3
        logOutButton.enabled = false
        logOutSpinner.startAnimating()
        Udacity.logout { (success, status) -> Void in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.mapView.alpha = 1.0
                    self.logOutButton.enabled = true
                    self.logOutSpinner.stopAnimating()
                })
            }
        }
    }
    
    @IBAction func addLocationButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func refreshButtonTapped(sender: UIBarButtonItem) {
        annotations = []
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        addAnnotations()
    }
    
}