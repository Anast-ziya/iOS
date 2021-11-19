//
//  CustomView.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 19.11.21.
//

import UIKit

class CustomView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var imageOne: UIImageView!
    @IBOutlet private weak var imageTwo: UIImageView!
    
    // for using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
