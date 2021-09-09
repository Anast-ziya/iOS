//
//  ViewController.swift
//  ColorWizard
//
//  Created by Anastasia Burak on 29.08.21.
//

import UIKit

class ColorPresenterViewController: UIViewController, ColorTransferDelegate {
    
    @IBOutlet weak var ColorNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func userDidChoose(color: UIColor, withName colorName: String) {
        view.backgroundColor = color
        ColorNameLabel.text = colorName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentColorPickerViewController" {
            guard let colorPickerViewController = segue.destination as? ColorPickerViewController else { return }
            colorPickerViewController.delegate = self
        }
    }

}

