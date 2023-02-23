//
//  Extensions.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/21/23.
//

import UIKit

//MARK: - UIFont Extensions
extension UIFont {
    static func getRegularFont(size:Int) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: CGFloat(size))!
    }
    static func getLightFont(size:Int) -> UIFont {
        return UIFont(name: "AvenirNext-UltraLight", size: CGFloat(size))!
    }
}



