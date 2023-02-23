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
        static let ButtonHeight = 45
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
        struct Auth {
            static let signin = "SignIn";
            static let signup = "SignUp";
            static let forgotPassword = "ForgotPassword";
            static let resetPassword = "ResetPassword";
        }
    }
    
    
    //MARK: - ReuseIdentifier
    struct ReuseIdentifier {
        static let OnboardingCellIdentifier = "OnboardingCellIdentifier";
    }
    
    
}
