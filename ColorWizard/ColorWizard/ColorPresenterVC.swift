//
//  ViewController.swift
//  ColorWizard
//
//  Created by Anastasia Burak on 29.08.21.
//

import UIKit

class ColorPresenterVC: UIViewController, ColorTransferDelegate {
    
    @IBOutlet weak var ColorNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func userDidChoose(color: UIColor, withName colorName: String) {
        view.backgroundColor = color
        ColorNameLbl.text = colorName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentColorPickerVC" {
            guard let colorPickerVC = segue.destination as? ColorPickerVC else { return }
            colorPickerVC.delegate = self
        }
    }

}

