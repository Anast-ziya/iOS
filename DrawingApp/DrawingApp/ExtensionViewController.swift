//
//  ExtensionViewController.swift
//  DrawingApp
//
//  Created by Anastasia Burak on 9.12.21.
//

import UIKit

extension ViewController {
    func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async {
            let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            dialog.addAction(okAction)
            self.present(dialog, animated: true, completion: nil)
        }
    }
}
    
