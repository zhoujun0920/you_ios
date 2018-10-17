//
//  UITextField+extension.swift
//  you
//
//  Created by Jun Zhou on 10/16/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isEmpty() -> Bool {
        if let text = self.text {
            return text.isEmpty
        }
        return true
    }
}
