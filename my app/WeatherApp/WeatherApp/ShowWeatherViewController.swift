//
//  ShowWeatherViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit
import WeatherAPI

internal class ShowWeatherViewController: UIViewController {

    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    private var data: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let temperature = data?.temperature {
            background.image = UIImage(named: setImage(temperature))
            cityLabel.text = data?.city
            temperatureLabel.text = String(temperature)
        }
        
    }
    
    func set(weatherData: WeatherData) {
        self.data = weatherData
    }

}
