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
        static let SplashDelayTime = 2
        static let AppName = "FoodMIMA"
        static let buttonHeight = 45
        static let isUserLoggedIn = "isUserLoggedIn"
    }
    //MARK: - Colors
    struct Colors {
        static let colorPrimary = "ColorPrimary";
        static let accentColor  = "AccentColor";
        
    }
    
    //MARK: - Lottie Animation
    struct LottieFiles{
        static let loadingSpinner = "splash-loading";
        static let splashSpinner = "splash-loading";
        // other assets
        static let welcomeOnboard = "welcome-onboard";
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
    
    //MARK: - Firebase
    struct Firebase{
        struct UserCollection{
            static let collectionName = "users"
            static let fullName = "fullName"
            static let email = "email"
            
        }
        
        
        
    }
    
    
    
    //MARK: - ReuseIdentifier
    struct ReuseIdentifier {
        static let OnboardingCellIdentifier = "OnboardingCellIdentifier";
    }
    
    
}
