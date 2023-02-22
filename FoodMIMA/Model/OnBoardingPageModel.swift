//
//  OnBoardingPage.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/20/23.
//

import Foundation

/// - Description: ON boarding Model
/// - Important: Use only Lottie File Name, Image Not supported
struct OnBoardingPageModel{
    let title:String;
    let subTitle:String;
    let imageName:String;
    
}

/// - Description: On Boarding Static Data
/// - Important: returns Static Data
/// - Returns: [OnBoardingPageModel]
struct OnBoardingPageModelData {
    static func getAllScreenData() -> [OnBoardingPageModel] {
        return [
            OnBoardingPageModel(title: "Restaurant Exploration", subTitle: "Unleashing Your Inner Foodie: An exploration of the best and cheap restaurants in town, by discovering new flavors, and embarking on a culinary adventure in your city.", imageName: K.Images.OnBoarding.imageOne),
            OnBoardingPageModel(title: "Savoring The City", subTitle: "A Guide to Exploring Local Restaurants - Discovering hidden gems and culinary delights in your neighborhood. ", imageName: K.Images.OnBoarding.imageTwo),
            OnBoardingPageModel(title: "Dining Deligh", subTitle: "Feast Your Way Through the City - A foodie's guide to the most delicious eateries in your area.", imageName: K.Images.OnBoarding.imageThree)
        ];
    }
}
