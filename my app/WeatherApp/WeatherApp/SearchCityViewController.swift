//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 29.09.21.
//

import UIKit
import WeatherAPI

class SearchCityViewController: UIViewController {

    @IBOutlet private weak var helpLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let city = searchBar.text {
            WeatherFramework.getResponse(city: city.replacingOccurrences(of: " ", with: "%20")) { [self] (weatherData, error) in
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
    }

    func showAlert(_ message: String) {
       let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!)-> Void in })
       dialog.addAction(okAction)
       self.present(dialog, animated: true, completion: nil)
   }
}
