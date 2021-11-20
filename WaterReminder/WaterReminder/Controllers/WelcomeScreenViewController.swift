//
//  WelcomeScreenViewController.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 11.11.21.
//

import UIKit



final class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var pickerLabelDisplayed: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var getStartedButton: UIButton!
    @IBOutlet private weak var userPreferencesInfoLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    enum Step: Int, CaseIterable {
        case welcome
        case unit
        case age
        case weight
        case activityLevel
        case updateUserPreferences
        case userPreferencesInfo
        
        var title: String? {
            switch self {
            case .welcome: return nil
            case .unit: return "Unit"
            case .age: return "Age"
            case .weight: return "Weight in"
            case .activityLevel: return "Activity Level"
            case .updateUserPreferences: return nil
            case .userPreferencesInfo: return nil
            }
        }
        
        var isLastStep: Bool {
            self == Step.allCases.last
        }
        mutating func next() -> Bool {
            if let nextStep = Step(rawValue: rawValue + 1) {

                self = nextStep
                return true
            } else {
                return false
            }
        }
    }
    
    private var currentStep: Step = .welcome
    private let preferencesManager = PreferencesManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.layer.cornerRadius = 30
        
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2.5)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //prevents the user from dismissing the modal view
        isModalInPresentation = true
        infoLabel.text = "We need to collect some information before we start. We need it to calculate your water goal! The data is only stored locally on your iPhone."
        updateUI()
    }
    
    //These values are preset so that if the user doesn't scroll any of the uiPickers, then the default value will stay
    private var unit: Unit = .metric
    private var age: Int = 10
    private var defaultweightInKg: Float = 20
    private var activityLevel: ActivityLevel = .low
    
    private var progressPercentage: Float {
        return Float(currentStep.rawValue) / Float(Step.allCases.count)
    }
    
    private func updateUI() {
        progressView.progress = 0
        userPreferencesInfoLabel.isHidden = true
        
        let hidePicker = currentStep == .welcome
        pickerView.isHidden = hidePicker
        nextButton.isHidden = hidePicker
        progressView.isHidden = hidePicker
        pickerLabelDisplayed.isHidden = hidePicker
        pickerLabelDisplayed.text = currentStep.title
        
        getStartedButton.isHidden = !hidePicker
        infoLabel.isHidden = !hidePicker
        
        if !hidePicker {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        
        
        if currentStep.isLastStep {
            userPreferencesInfoLabel.isHidden = false
            pickerView.isHidden = true
            let waterToConsumeConverted = preferencesManager.unitDisplayed
            userPreferencesInfoLabel.text = "You should consume \(waterToConsumeConverted) of water daily. Keep in mind that this is only an estimate"
            nextButton.setTitle("Go!", for: .normal)
        }
        
        if currentStep == .weight {
            var displayedUnit = "Kg"
            if unit == .imperial {displayedUnit = "Ibs"}
            if let currentStepTitle = currentStep.title {
                pickerLabelDisplayed.text = "\(currentStepTitle) \(displayedUnit)"
            }
        }
        
        pickerView.reloadAllComponents()
        progressView.setProgress(progressPercentage, animated: true)
    }

    
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        next()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        next()
    }
    
    private func next() {
        if currentStep.next() {
            if currentStep == .updateUserPreferences {
                PreferencesManager.shared.currentUserPrefrences = UserPrefrences(unit: unit, weightInKg: defaultweightInKg, age: age, activityLevel: activityLevel)
                PreferencesManager.shared.updateWeight()
                next()
            }
            updateUI()
        } else {
            PreferencesManager.shared.updateUserPreferences()
            dismiss(animated: true)
        }
    }
}

// MARK: - Extension of this View Controller with UIPickerViewDelegate and UIPickerViewDataSource

extension WelcomeScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentStep {
        case .welcome: return 0
        case .unit: return  preferencesManager.unitDataSource.count
        case .weight:
            if unit == .metric {
                return preferencesManager.weightKgDataSource.count
            } else {
                return preferencesManager.weightIbsDataSource.count
            }
        case .age: return preferencesManager.ageDataSource.count
        case .activityLevel: return preferencesManager.activtiyLevelDataSource.count
        case .updateUserPreferences: return 0
        case .userPreferencesInfo: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch currentStep {
        case .welcome:
            return nil
        case .unit:
            return preferencesManager.unitDataSource[row].description
        case .weight:
            if unit == .metric {
                return "\(preferencesManager.weightKgDataSource[row])"
            } else {
                return "\(preferencesManager.weightIbsDataSource[row])"
            }
        case .age:
            return "\(preferencesManager.ageDataSource[row])"
        case .activityLevel:
            return preferencesManager.activtiyLevelDataSource[row].description
        case .updateUserPreferences: return nil
        case .userPreferencesInfo: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch currentStep {
        case .welcome: break
        case .unit:
        //this is where unit conversion functions should be excecuted if the user changes units
            unit = preferencesManager.unitDataSource[row]
        case .weight:
            defaultweightInKg = Float(preferencesManager.weightKgDataSource[row])
        case .age:
            age = preferencesManager.ageDataSource[row]
        case .activityLevel:
            activityLevel = preferencesManager.activtiyLevelDataSource[row]
        case .updateUserPreferences: break
        case .userPreferencesInfo: break
        }
        
    }
    
}

