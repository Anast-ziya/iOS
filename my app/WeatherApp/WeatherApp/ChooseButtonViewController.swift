//
//  ChooseButtonViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit
import WeatherAPI

public class ChooseButtonViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func cityButtonWasPressed(_ sender: UIButton!) {
        if let city = sender.titleLabel?.text {
            WeatherFramework.getResponse(city: city) { (weatherData, error) in
                if let error = error {
                    showAlert(error)
                } else {
                    DispatchQueue.main.async {
                        if let data = weatherData {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "showWeather") as! ShowWeatherViewController
                            vc.set(weatherData: data)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
        }
    
    func showAlert(_ message: String) {
           let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!)-> Void in })
           dialog.addAction(okAction)
           self.present(dialog, animated: true, completion: nil)
       }
    }
}


