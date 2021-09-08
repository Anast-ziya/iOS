//
//  ViewController.swift
//  OnOffView
//
//  Created by Anastasia Burak on 1.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var onOffLabel: UILabel!
    
    @IBOutlet weak var onOffButton: UIButton!
    
    var switchStatus: SwitchStatus = .off
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func onOffButtonWasPressed(_ sender: Any) {
        switchStatus.toggle()
        if switchStatus == .off {
            onOffButton.setImage(UIImage(named: "offBtn")!, for: .normal)
            view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            onOffLabel.text = "🌚 OFF 🌚"
            onOffLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            onOffButton.setImage(UIImage(named: "onBtn")!, for: .normal)
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            onOffLabel.text = "🌝 ON 🌝"
            onOffLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
    }
    
}

