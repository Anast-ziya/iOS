//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 26.09.21.
//

import UIKit

private class SearchCityViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var helpLabel: UILabel!
    
    private let dataManager = DataManager(NewURL: API.AuthenticatedBaseURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
    
extension SearchCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        dataManager.weatherDataForCityName(city: searchBar.text!.replacingOccurrences(of: " ", with: "%20")) { [self] (response, error) in
            DispatchQueue.main.async {
                guard let JSON = response as? [String:AnyObject] else {
                    showAlert("Json response wasn't converted")
                    return
                }
                if let weatherData = WeatherData(JSON: JSON) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "showWeather") as! ShowWeatherViewController
                    vc.set(weatherData: weatherData)
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    showAlert("Incorrect city")
                }
            }
        }
    }

    private func showAlert(_ message: String) {
       let dialog = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert:UIAlertAction!)-> Void in })
       dialog.addAction(okAction)
       self.present(dialog, animated: true, completion: nil)
   }
}
        


