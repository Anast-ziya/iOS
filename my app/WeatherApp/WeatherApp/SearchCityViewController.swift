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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.text {
        startSearch([city.replacingOccurrences(of: " ", with: "%20")])
        }
   }
}
