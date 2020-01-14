//
//  UIColor.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 25..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let logoColor = UIColor(hex: 0xFA3B3B)
    static let greenLight = UIColor(red: 170/255, green: 226/255, blue: 213/255, alpha: 1)
    static let green = UIColor(red: 30/255, green: 181/255, blue: 148/255, alpha: 1)
    static let greenDart = UIColor(red: 17/255, green: 103/255, blue: 84/255, alpha: 1)
    
    static let soGood =  UIColor(red: 30/255, green: 181/255, blue: 148/255, alpha: 1)
    static let good = UIColor(red: 30/255, green: 114/255, blue: 103/255, alpha: 1)
    static let standard = UIColor(red: 48/255, green: 65/255, blue: 71/255, alpha: 1)
    static let bad = UIColor(red: 145/255, green: 9/255, blue: 17/255, alpha: 1)
    static let soBad = UIColor(red: 214/255, green: 21/255, blue: 30/255, alpha: 1)

    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha : a
        )
    }
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
