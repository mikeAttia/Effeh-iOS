//
//  UIView+Constraints.swift
//  Effeh
//
//  Created by Michael Attia on 7/5/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

extension UIView{
    func pinEdgesTo(_ view: UIView){
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal , toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal , toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal , toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal , toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
    }
}
