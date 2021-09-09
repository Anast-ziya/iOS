//
//  ColorPickerVC.swift
//  ColorWizard
//
//  Created by Anastasia Burak on 29.08.21.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    var delegate: ColorTransferDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func colorButtonWasPressed(sender: UIButton){
        
        if delegate != nil, let backgroundColor = sender.backgroundColor, let titleLable = sender.titleLabel, let text = titleLable.text {
            delegate?.userDidChoose(color: backgroundColor, withName: text)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
