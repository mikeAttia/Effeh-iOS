//
//  UIColor+hex.swift
//  Effeh
//
//  Created by Michael Attia on 6/23/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init?(hex: String, alpha: CGFloat = 1.0){
        let cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased().replacingOccurrences(of: "#", with: "")
        
        guard cString.count == 6 else { return nil }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
