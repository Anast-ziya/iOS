//
//  UIViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 2.10.21.
//

import WeatherAPI
import Foundation
import UIKit

fileprivate var spinner: UIView?

extension UIViewController {
    
    func swichViewController(_ data: WeatherData) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: nameOfMainStoryboard, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: identifierOfShowWeatherViewController) as? ShowWeatherViewController {
                self.removeSpinner()
                vc.set(weatherData: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            dialog.addAction(okAction)
            self.present(dialog, animated: true, completion: nil)
            self.removeSpinner()
        }
    }
    
    func showSpinner() {
        spinner = UIView(frame: self.view.bounds)
        spinner?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let spin = UIActivityIndicatorView(style: .large)
        if let spinner = spinner {
            spin.center = spinner.center
            spin.startAnimating()
            spinner.addSubview(spin)
            self.view.addSubview(spinner)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
}
