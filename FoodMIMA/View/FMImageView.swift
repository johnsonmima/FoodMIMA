//
//  FMImageView.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/22/23.
//

import UIKit

class FMImageView: UIImageView {

    required init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
