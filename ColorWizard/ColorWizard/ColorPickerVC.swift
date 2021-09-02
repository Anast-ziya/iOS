//
//  ColorPickerVC.swift
//  ColorWizard
//
//  Created by Anastasia Burak on 29.08.21.
//

import UIKit

class ColorPickerVC: UIViewController {
    
    var delegate: ColorTransferDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func colorBtnWasPressed(sender: UIButton){
        
        if delegate != nil {
            delegate?.userDidChoose(color: sender.backgroundColor!, withName: sender.titleLabel!.text!)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
