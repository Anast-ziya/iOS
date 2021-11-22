//
//  SecondCustomView.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 20.11.21.
//

import UIKit

class SecondCustomView: UIView {

    @IBOutlet private var secondCustomView: UIView!
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    
    // for using SecondCustomView in code
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(viewName: secondCustomViewName)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(viewName: secondCustomViewName)
    }
}
