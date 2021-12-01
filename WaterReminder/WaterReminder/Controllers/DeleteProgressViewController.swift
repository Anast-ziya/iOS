//
//  DeleteProgressViewController.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 28.11.21.
//

import UIKit

class DeleteProgressViewController: UIViewController {

    @IBOutlet private weak var selectDrinkLabel: UILabel!
    @IBOutlet private weak var listOfDrinks: UIPickerView!
    @IBOutlet private weak var waterAmountLabel: UILabel!
    @IBOutlet private weak var unitLabel: UILabel!
    @IBOutlet private weak var waterSlider: UISlider!
    
    
    var list = ["Water", "Tea", "Coffee", "Milk"]
    private let unitIsMetric = PreferencesManager.shared.currentUserPrefrences?.unit == .metric
    private var amountOfWater: Int {
        var valueFromWaterSlider = waterSlider.value
        if selectDrinkLabel.text == "Tea" {
            valueFromWaterSlider *= 0.98
        } else if selectDrinkLabel.text == "Coffee" {
            valueFromWaterSlider *= 0.8
        } else if selectDrinkLabel.text == "Milk" {
            valueFromWaterSlider *= 0.88
        }
        return unitIsMetric ? Int(valueFromWaterSlider * 100) : Int(valueFromWaterSlider * 3.4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        waterAmountLabel.text = "\(amountOfWater)"
        if unitIsMetric {
            unitLabel.text = "ml"
        } else {
            unitLabel.text = "Oz"
        }
    }
    
    let step: Float = 0.001
    
    @IBAction private func waterSliderChanged(_ sender: Any) {
        let roundedValue = round(waterSlider.value / step) * step
        waterSlider.value = roundedValue
        waterAmountLabel.text = "\(amountOfWater)"
    }
    
    @IBAction private func deleteWaterTapped() {
        guard let unit = PreferencesManager.shared.currentUserPrefrences?.unit else { return }
        let amountOfWaterInMl = PreferencesManager.shared.waterUnitConverter(waterAmount: amountOfWater, currentUnit: unit)
        let residuum = Int(WaterManager.shared.todaysWaterCondsumption) - amountOfWaterInMl
        
        if residuum >= 0 {
            WaterManager.shared.add(glassOfWater: GlassOfWater(amount: -amountOfWaterInMl))
        } else {
            WaterManager.shared.add(glassOfWater: GlassOfWater(amount: (-amountOfWaterInMl - residuum)))
        }
        dismiss(animated: true)
    }
    
    @IBAction private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension DeleteProgressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectDrinkLabel.text = self.list[row]
    }
    
}
