//
//  FMUILabel.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/22/23.
//

import UIKit

class FMUILabel: UILabel {
    
    // label enum types
    enum FMLabelType {
        case primary, secondary, customColor, defaultType
    }
    /// - Parameters: labelType, withTextAlignment, numberOfLines, withCustomColor
    required  init(labelType:FMLabelType = .defaultType,
                   withTextAlignment alignment:NSTextAlignment = .center,
                   numberOfLines: Int = 0, withCustomColor customColor:UIColor = .red  ) {
        super.init(frame: .zero)
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        
        switch (labelType){
        case .primary:
            self.textColor = .label
        case .secondary:
            self.textColor = .secondaryLabel
        case .customColor:
            self.textColor = customColor
        default:
            self.textColor = .label
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
