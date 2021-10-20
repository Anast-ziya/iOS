//
//  ChooseButtonViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit
import CoreLocation

class ChooseButtonViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    @IBAction private func cityButtonWasPressed(_ sender: UIButton!) {
        if let city = sender.titleLabel?.text {
            self.showSpinner()
            if city == locationButton {
                requestLocationIfNeeded()
            } else {
                SearchManager.startSearch([city]) { (data, error) in
                    if error != nil {
                        self.showAlert("Something goes wrong.")
                    } else {
                        if let data = data {
                            self.swichViewController(data)
                        }
                    }
                }
            }
        }
        
        func requestLocationIfNeeded() {
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                locationRequest()
            case .denied:
                permissionDenied()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled()  {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        requestLocationIfNeeded()
                    }
                }
            default:
                locationManager.requestAlwaysAuthorization()
            }
        }
    }
}

extension ChooseButtonViewController {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        SearchManager.startSearch([locValue.latitude, locValue.longitude]) { (data, error) in
            if error != nil {
                self.showAlert("Something goes wrong.")
            } else {
                if let data = data {
                    self.swichViewController(data)
                }
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert("Failed to find user's location.")
        removeSpinner()
    }
    
    func locationRequest() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.requestLocation()
        }
    }
    func permissionDenied() {
        showAlert("Location use was rejected. Change this in your phone settings.")
        removeSpinner()
    }
}

