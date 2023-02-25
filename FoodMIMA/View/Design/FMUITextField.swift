//
//  FMUITextField.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/22/23.
//

import UIKit

class FMUITextField: UITextField {
    
    enum inputeType {
        case email, password, text, mobile
    }
    
    
    
    required init(input:inputeType, placeholder:String){
        
        super.init(frame: .zero)
        self.textColor = .darkGray
        self.borderStyle = .roundedRect
        self.backgroundColor = .secondarySystemBackground
        self.font = .getRegularFont(size:15)
        self.placeholder = placeholder
        self.clipsToBounds = true
        self.clearButtonMode = .always
       
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        
        
        switch (input){
        case .mobile:
            self.keyboardType = .phonePad
            self.textContentType = .telephoneNumber
            self.returnKeyType = .next
        case .email:
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            self.returnKeyType = .next
        case .password:
            self.keyboardType = .default
            self.isSecureTextEntry = true
            self.textContentType = .oneTimeCode
            self.returnKeyType = .done
        default:
            self.keyboardType = .default
            self.returnKeyType = .next
            
            
        }
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
