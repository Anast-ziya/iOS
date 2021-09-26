//
//  ChooseButtonViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit

class ChooseButtonViewController: UIViewController {

    @IBOutlet private weak var searchButton: UIBarButtonItem!
    
    private let dataManager = DataManager(NewURL: API.AuthenticatedBaseURL)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func cityButtonWasPressed(_ sender: UIButton!) {
        // Fetch Weather Data
        if let city = sender.titleLabel?.text {
            dataManager.weatherDataForCityName(city: city) { [self] (response, error) in
                guard let JSON = response as? [String:AnyObject] else {
                    showAlert("Json response wasn't converted")
                    return
                }
                if let weatherData = WeatherData(JSON: JSON) {
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "showWeather") as! ShowWeatherViewController
                        vc.set(weatherData: weatherData)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    showAlert("Something goes wrong with json response")
                }
            }
        } else {
            showAlert("Something goes wrong. Try again.")
        }
    }
    
    private func showAlert(_ message: String) {
           let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!)-> Void in })
           dialog.addAction(okAction)
           self.present(dialog, animated: true, completion: nil)
       }
    
}


