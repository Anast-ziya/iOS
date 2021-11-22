//
//  ExtensionUIView.swift
//  customElement+Stack
//
//  Created by Anastasia Burak on 20.11.21.
//

import UIKit

extension UIView {
    func instantiateFrom<T: UIView>(nibName: String) -> T {
        let nib = UINib(nibName: nibName, bundle: nil)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName))")
        }
        return view
    }
    
    func xibSetup(viewName: String) {
        let view = instantiateFrom(nibName: viewName)
        addSubview(view)
        stretch(view: view)
    }
    
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: topAnchor),
                                     view.leftAnchor.constraint(equalTo: leftAnchor),
                                     view.rightAnchor.constraint(equalTo: rightAnchor),
                                     view.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
