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
        initializeHideKeyboard()
    }
    
}

extension SearchCityViewController: UISearchBarDelegate {
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(swipe)
    }
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.text {
            showSpinner()
            SearchManager.startSearch([city.replacingOccurrences(of: " ", with: "%20")]) { (data, error) in
                if error != nil {
                    self.showAlert("Can't find this city.")
                } else {
                    if let data = data {
                        self.swichViewController(data)
                    }
                }
            }
        }
    }
}
