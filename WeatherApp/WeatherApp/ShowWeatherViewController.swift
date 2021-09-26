//
//  ShowWeatherViewController.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 23.09.21.
//

import UIKit

internal class ShowWeatherViewController: UIViewController {

    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    var data: WeatherData!
    
    override func viewDidLoad() {
        setImage()
        super.viewDidLoad()
        cityLabel.text = data.city
        temperatureLabel.text = String(data.temperature)

    }
    
    func  setImage() {
        if data.temperature >= 20 {
            background.image = UIImage(named: "background-hot")
        }
        else if data.temperature < 20 && data.temperature >= 10 {
            background.image = UIImage(named: "background-warm")
        }
        else if data.temperature < 10 && data.temperature >= 0 {
            background.image = UIImage(named: "background-chilly")
        }
        else if data.temperature < 0 && data.temperature >= -5 {
            background.image = UIImage(named: "background-frost")
            cityLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            temperatureLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            background.image = UIImage(named: "background-cold")
        }
    }
    
    func set(weatherData: WeatherData) {
        self.data = weatherData
    }

}
