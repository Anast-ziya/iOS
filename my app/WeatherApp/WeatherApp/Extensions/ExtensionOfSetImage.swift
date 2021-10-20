//
//  ExtensionOfSetImage.swift
//  WeatherApp
//
//  Created by Anastasia Burak on 18.10.21.
//

import Foundation

extension ShowWeatherViewController {
    
    func setImage(_ temperature: Double) -> String {
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
