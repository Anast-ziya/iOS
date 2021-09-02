//
//  ColorTransferDelegate.swift
//  ColorWizard
//
//  Created by Anastasia Burak on 29.08.21.
//

import UIKit

protocol ColorTransferDelegate {
    func userDidChoose(color: UIColor, withName colorName: String)
}
