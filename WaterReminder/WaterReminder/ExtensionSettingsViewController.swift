//
//  ExtensionSettingsViewController.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 17.11.21.
//

import UIKit

extension SettingsTableViewController {
    func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            dialog.addAction(okAction)
            self.present(dialog, animated: true, completion: nil)
        }
    }
}
    
