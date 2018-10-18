//
//  UIColor+extension.swift
//  you
//
//  Created by Jun Zhou on 10/16/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct FlatColor {
        struct Green {
            static let PasswordCorrectGreen = UIColor(netHex: 0x2CC4AE) //R:44, G:196, B:174
        }
        
        struct Blue {
            static let MainAppBlue = UIColor(netHex: 0x5026A6) //R:80, G:38, B:166
            static let BlockNext = UIColor.lightGray //R:211, G:201, B:233
        }
        
        struct Red {
            static let PasswordErrorRed = UIColor(netHex: 0xD83560) //R:216, G:53, B:96
        }
    }
}
