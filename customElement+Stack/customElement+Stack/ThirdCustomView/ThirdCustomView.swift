//
//  ThirdCustomView.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 22.11.21.
//

import UIKit


class ThirdCustomView: UIView {

    @IBOutlet private var thirdCustomView: UIView!
    @IBOutlet private weak var selectDateLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    // for using SecondCustomView in code
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(viewName: thirdCustomViewName)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(viewName: thirdCustomViewName)
    }
}
