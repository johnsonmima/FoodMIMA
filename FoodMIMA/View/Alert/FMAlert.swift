//
//  FMAlert.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/23/23.
//

import UIKit

class FMAlert {
    
    // basic alert
     private static func showBasicAlert(on vc:UIViewController, withTitle title:String, withMessage message:String){
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alert.view.tintColor = .white
         alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(named: K.Colors.accentColor)
         // set alert title color
         alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.getDemiBoldFont(size: 17), NSAttributedString.Key.foregroundColor : UIColor.white]), forKey: "attributedTitle")
         // set alert message color
         alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.getRegularFont(size: 15),NSAttributedString.Key.foregroundColor :UIColor.white]), forKey: "attributedMessage")
        
         // action
         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Error occured"), style: .default, handler: nil))
         //present
         DispatchQueue.main.async {
             vc.present(alert, animated: true, completion: nil)
         }
         
    }
    
}


extension FMAlert {
    
    //MARK: - Validation Alerts
    
    static func showEmptyFieldAlert(on vc: UIViewController, forFieldName fieldName:String) {
        self.showBasicAlert(on: vc, withTitle: "", withMessage: "Please enter your \(fieldName)")
    }
    
    static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, withTitle: "", withMessage: "Please enter a valid email address")
    }
    
    static func showInvalidFullNameAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, withTitle: "", withMessage: "Full name must be greater than 3 characters")
    }
    
    static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, withTitle: "Password!", withMessage: "Minimum of 6 character, with at least 1 alphabet & 1 special character")
    }
    
    
    
    
}



