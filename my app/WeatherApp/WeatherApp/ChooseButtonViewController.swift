//
//  ChooseButtonViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit
import CoreLocation

public class ChooseButtonViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        startSearch([locValue.latitude, locValue.longitude])
        self.removeSpinner()
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
   }
    
    @IBAction func cityButtonWasPressed(_ sender: UIButton!) {
        if let city = sender.titleLabel?.text {
            if city == locationButton {
                locationManager.requestWhenInUseAuthorization()
                self.showSpinner()
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyReduced
                    locationManager.requestLocation()
                }
            } else {
                startSearch([city])
            }
        }
    }
}



