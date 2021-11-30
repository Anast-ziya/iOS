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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(viewName: thirdCustomViewName)
    }

}
