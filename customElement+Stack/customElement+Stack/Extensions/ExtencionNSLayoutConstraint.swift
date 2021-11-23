//
//  ExtencionNSLayoutConstraint.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 23.11.21.
//

import Foundation
import UIKit

extension NSLayoutConstraint {

    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}

