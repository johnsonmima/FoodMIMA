//
//  SplashVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit

class SplashVC: UIViewController {
    
    // loading animated view
    let splashLoadingAnimation = FMLottieAnimatedView(withLottieFile: "loading.json");

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // show loading indicator
        self.setupLoadingIndicator();
        
        //TODO: Check if user is signed in
        self.IsUserSignedIn()

    }
    
    
    /// - Description: This method check if user is logged in or not
    private func IsUserSignedIn() {
        let isSignedIn = false;
        
        
        if (isSignedIn){
            // navigate to user home
        }else{
            // navigate to signin screen
        }
      
    }
    
    // loading indicator
    private func setupLoadingIndicator(){
        self.view.addSubview(splashLoadingAnimation);
        splashLoadingAnimation.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            splashLoadingAnimation.widthAnchor.constraint(equalToConstant: 200),
            splashLoadingAnimation.heightAnchor.constraint(equalToConstant: 200),
            splashLoadingAnimation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            splashLoadingAnimation.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    
    

  

}
