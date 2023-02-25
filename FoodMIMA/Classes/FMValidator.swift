//
//  FMValidator.swift
//  FoodMIMA
//  Validates user input
//  Created by Johnson Olusegun on 2/23/23.
//

import Foundation

struct FMValidator{
    
    //MARK: - Empty Field
    /// - Parameters:value:String
    /// - Returns: Bool
    static func isEmpty(with value:String) -> Bool {
        return value.count <= 0
    }
    
    //MARK: - Email Validation
    /// - Parameters:value:String
    /// - Returns: Bool
    static func isInvalidEmail(with value:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailPred.evaluate(with: value)
    }
    
    //MARK: - Full Name Validation
    /// - Parameters:value:String
    /// - Returns: Bool
    static func isInvalidFullName(with value: String) -> Bool {
        let regex = "[A-Za-z ]{3,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return !test.evaluate(with: value)
    }
    //MARK: - Password Validation
    //    length 6 to 16.
    //    One Alphabet in Password.
    //    One Special Character in Password.
    /// - Parameters:value:String
    /// - Returns: Bool
    static func isInvalidPassword(with value: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return !passwordTest.evaluate(with: value)
        
    }
    
    
    
    
}
