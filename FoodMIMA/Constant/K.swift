//
//  K.swift
//  FoodMIMA
//  Saving constant files
//  Created by Johnson Olusegun on 2/20/23.
//

import Foundation

struct K {
    
    //MARK: - General
    struct General {
        static let SplashDelayTime = 1;
        static let AppName = "FoodMIMA";
    }
    //MARK: - Colors
    struct Colors {
        static let colorPrimary = "ColorPrimary";
        static let accentColor  = "AccentColor";
        
    }
    
    //MARK: - Images
    struct Images{
        struct OnBoarding{
            static let imageOne = "OnBFoodImage1";
            static let imageTwo = "OnBFoodImage2";
            static let imageThree = "OnBFoodImage3";
        }
    }
    
    
    //MARK: - ReuseIdentifier
    struct ReuseIdentifier {
        static let OnboardingCellIdentifier = "OnboardingCellIdentifier";
    }
    
    
}
