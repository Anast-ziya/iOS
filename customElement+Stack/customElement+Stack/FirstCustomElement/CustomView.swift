//
//  CustomView.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 19.11.21.
//

import UIKit

class CustomView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageOne: UIImageView!
    @IBOutlet private weak var imageTwo: UIImageView!
    
    // for using CustomView in code
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(viewName: customViewName)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(viewName: customViewName)
    }
    
}
