//
//  UIViewController+ExtensionOfSearch.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 2.10.21.
//

import WeatherAPI
import Foundation
import UIKit

extension UIViewController {
    
    func startSearch<T> (_ searchParam: Array<T>) {
        WeatherFramework.getResponse(city: searchParam) { (weatherData, error) in
            DispatchQueue.main.async {
            if let error = error {
               showAlert(error)
            } else {
                    if let data = weatherData {
                        let storyboard = UIStoryboard(name: nameOfMainStoryboard, bundle: nil)
                        if let vc = storyboard.instantiateViewController(withIdentifier: identifierOfSsowWeatherViewController) as? ShowWeatherViewController{
                            vc.set(weatherData: data)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
        func showAlert(_ message: String) {
            let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            dialog.addAction(okAction)
            self.present(dialog, animated: true, completion: nil)
        }
    }
    
    func  setImage(_ temperature: Double) -> String {
            if temperature >= 20 {
                return "background-hot"
            }
            else if temperature < 20 && temperature >= 10 {
                return "background-warm"
            }
            else if temperature < 10 && temperature >= 0 {
                return "background-chilly"
            }
            else if temperature < 0 && temperature >= -5 {
                return "background-frost"
            }
            else {
                return "background-cold"
            }
        }
    
}
