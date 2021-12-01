//
//  SettingsTableViewController.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 15.11.21.
//

import UIKit
import Foundation

enum Picker: Int {
       case unit
       case weightKg
       case weightIbs
       case age
       case activityLevel
   }

protocol UnitChangedDelegate: AnyObject {
    func unitChanged()
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet private weak var unitPickerView: UIPickerView!
    @IBOutlet private weak var switchState: UISwitch!
    @IBOutlet private weak var weightPickerViewKg: UIPickerView!
    @IBOutlet private weak var weightPickerViewIbs: UIPickerView!
    @IBOutlet private weak var agePickerView: UIPickerView!
    @IBOutlet private weak var activityLevelPickerView: UIPickerView!
    
    @IBOutlet private weak var unitLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var activityLabel: UILabel!
    
    private let preferencesManager = PreferencesManager.shared
    weak var delegate: UnitChangedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchState.isOn = UserDefaults.standard.bool(forKey: "switchStatus")
        self.unitPickerView.delegate = self
        self.weightPickerViewKg.delegate = self
        self.weightPickerViewIbs.delegate = self
        self.agePickerView.delegate = self
        self.activityLevelPickerView.delegate = self
        
        unitPickerView.tag = Picker.unit.rawValue
        weightPickerViewKg.tag = Picker.weightKg.rawValue
        weightPickerViewIbs.tag = Picker.weightIbs.rawValue
        agePickerView.tag = Picker.age.rawValue
        activityLevelPickerView.tag = Picker.activityLevel.rawValue
        
        updateUI()
    }
    
    private func updateUI() {
        //Displaying the correct data in the pickers from previous user prefrences when loading the table view
        guard let safeCurrentPreferences = preferencesManager.currentUserPrefrences else {return}
        unitPickerView.selectRow(safeCurrentPreferences.unit.rawValue, inComponent: 0, animated: false)
        
        var indexOfKg = safeCurrentPreferences.weightInKg
        indexOfKg.round(.toNearestOrAwayFromZero)
        if let weightKgPickerIndex = preferencesManager.weightKgDataSource.firstIndex(of: Int(indexOfKg)) {
            weightPickerViewKg.selectRow(weightKgPickerIndex, inComponent: 0, animated: false)
        }
        
        let indexOfPounds = PreferencesManager.kgToPoundsConverter(kg: safeCurrentPreferences.weightInKg)
        if let weightIbsPickerIndex = preferencesManager.weightIbsDataSource.firstIndex(of: indexOfPounds) {
            weightPickerViewIbs.selectRow(weightIbsPickerIndex, inComponent: 0, animated: false)
        }
        
        if let agePickerIndex = preferencesManager.ageDataSource.firstIndex(of: safeCurrentPreferences.age) {
            agePickerView.selectRow(agePickerIndex, inComponent: 0, animated: false)
        }
        
        activityLevelPickerView.selectRow(safeCurrentPreferences.activityLevel.rawValue, inComponent: 0, animated: false)
        
        unitLabel.text = "\(safeCurrentPreferences.unit)"
        switch safeCurrentPreferences.unit {
        case .metric: weightLabel.text = "\(Int(safeCurrentPreferences.weightInKg))"
        case .imperial: weightLabel.text = "\(PreferencesManager.kgToPoundsConverter(kg: safeCurrentPreferences.weightInKg))"
        }
        
        ageLabel.text = "\(safeCurrentPreferences.age)"
        activityLabel.text = "\(safeCurrentPreferences.activityLevel)"
        
        if preferencesManager.currentUserPrefrences?.unit == .metric {
            weightPickerViewKg.isHidden = false
            weightPickerViewIbs.isHidden = true
        } else {
            weightPickerViewKg.isHidden = true
            weightPickerViewIbs.isHidden = false
        }
        
    }
    
    private func pickerIndexPath(for indexPath: IndexPath) -> IndexPath {
        IndexPath(row: indexPath.row + 1, section: indexPath.section)
    }
    
    @IBAction private func switchDidChange(_ sender: UISwitch) {
        let center = UNUserNotificationCenter.current()
        if sender.isOn {
            center.requestAuthorization(options: [.alert,.badge,.sound]) { grandted, error in
                if grandted {
                    self.showAlert("Great!", "You will get notifications, which will remind you to drink more!")
                } else {
                    self.showAlert("Error", "Please allow sending notifications in your phone settings")
                }
            }
            let content = UNMutableNotificationContent()
            content.title = "Are you there?"
            content.body = "This Is your body speaking. Don't forget to drink water or something like this!"
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        } else {
            showAlert("It's a pity :(", "You will not get notifications more. But don't forget to drink!")
            center.removeAllPendingNotificationRequests()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            UserDefaults.standard.set(switchState.isOn, forKey: "switchStatus")
        }
}

//MARK: - UIPickerView setup

extension SettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case Picker.unit.rawValue:
            return preferencesManager.unitDataSource.count
        case Picker.weightKg.rawValue:
            return preferencesManager.weightKgDataSource.count
        case Picker.weightIbs.rawValue:
            return preferencesManager.weightIbsDataSource.count
        case Picker.age.rawValue:
            return preferencesManager.ageDataSource.count
        case Picker.activityLevel.rawValue:
            return preferencesManager.activtiyLevelDataSource.count
        default:
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case Picker.unit.rawValue:
            return preferencesManager.unitDataSource[row].description
        case Picker.weightKg.rawValue:
            return "\(preferencesManager.weightKgDataSource[row])"
        case Picker.weightIbs.rawValue:
            return "\(preferencesManager.weightIbsDataSource[row])"
        case Picker.age.rawValue:
            return "\(preferencesManager.ageDataSource[row])"
        case Picker.activityLevel.rawValue:
            return preferencesManager.activtiyLevelDataSource[row].description
        default:
            return "Something wrong"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard var currentUserPrefrences = PreferencesManager.shared.currentUserPrefrences else {return}
        
        switch pickerView.tag {
            
        case Picker.unit.rawValue:
            //this is where unit conversion functions should be excecuted if the user changes units
            currentUserPrefrences.unit = preferencesManager.unitDataSource[row]
            preferencesManager.updateWeight()
            
        case Picker.weightKg.rawValue:
            if currentUserPrefrences.unit == .metric {
                let weightInKg = preferencesManager.weightKgDataSource[row]
                currentUserPrefrences.weightInKg = Float(weightInKg)
            }
            
        case Picker.weightIbs.rawValue:
            if currentUserPrefrences.unit == .imperial {
                let weightInIbs = preferencesManager.weightIbsDataSource[row]
                
                currentUserPrefrences.weightInKg = PreferencesManager.poundsToKgConverter(pounds: Float(weightInIbs))

            }
            
        case Picker.age.rawValue:
            let age = preferencesManager.ageDataSource[row]
            currentUserPrefrences.age = age
            
        case Picker.activityLevel.rawValue:
            currentUserPrefrences.activityLevel = preferencesManager.activtiyLevelDataSource[row]
        default:
            return
        }
        
        //update the user CurrentPreferences with the newly updated user preferences
        preferencesManager.currentUserPrefrences = currentUserPrefrences
        preferencesManager.updateUserPreferences()
        updateUI()
    }
}
