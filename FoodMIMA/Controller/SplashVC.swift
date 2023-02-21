//
//  SplashVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit

class SplashVC: UIViewController {
    
    // layout size manager
    var sizeManager:FMSizeManager? = nil;
    
    // loading animated view
    let splashLoadingAnimation = FMLottieAnimatedView(withLottieFile: "splash-loading", withAnimationSpeed: 1.6);
    
    override func viewDidLoad() {
        // setup layout manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width, withHeightWidth: self.view.safeAreaLayoutGuide.layoutFrame.height);
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // show loading indicator
        self.setupLoadingIndicator();
        
        //TODO: Check if user is signed in
        self.IsUserSignedIn()
        
    }
    
    //MARK: - IsUserSignedIn
    /// - Description: This method check if user is logged in or not
    private func IsUserSignedIn() {
        let isSignedIn = false;
        
        
        if (isSignedIn){
            // navigate to user home
        }else{
            // navigate to signin screen
        }
        
    }
    
    //MARK: - Setup Splash Indicator
    private func setupLoadingIndicator(){
        self.view.addSubview(splashLoadingAnimation);
        splashLoadingAnimation.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            splashLoadingAnimation.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 200) ?? 200),
            splashLoadingAnimation.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 200) ?? 200),
            splashLoadingAnimation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            splashLoadingAnimation.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    //MARK: - AuthRootController
    /// - Description: This method send the user to the welcome screen and then to signin and signup screen
    func loadAuthRootController(){
        
    }
    
    
    
    
    
    
}
