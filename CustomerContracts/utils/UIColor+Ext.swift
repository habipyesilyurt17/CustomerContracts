//
//  UIColor+Ext.swift
//  CustomerContracts
//
//  Created by Habip Yeşilyurt on 2.08.2023.
//

import UIKit

extension UIColor {
    static func gradientColor(with frame: CGRect) -> UIColor {
        
        let gradientColor = [
            UIColor(red: 0.99, green: 0.93, blue: 0.31, alpha: 1.00).cgColor,
            UIColor(red: 0.93, green: 0.65, blue: 0.25, alpha: 1.00).cgColor
        ]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = gradientColor
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)

        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return UIColor(patternImage: image!)
    }
}
