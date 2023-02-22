//
//  FMButton.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/21/23.
//

import UIKit

class FMButton: UIButton {
        
    
    required init(title:String, conerRadius:Double = 20) {
        super.init(frame:.zero)
        
        self.setTitle(title, for: .normal);
        self.setTitleColor(.lightText, for: .normal);
        self.setTitleColor(.secondaryLabel, for: .focused);
        self.backgroundColor = UIColor(named: K.Colors.accentColor);
        self.layer.cornerRadius = conerRadius;
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
