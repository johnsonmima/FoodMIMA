//
//  SplashVC.swift
//  FoodMIMA
//  Splash View Controller
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit

// TODO: FIX AND CLEAN UP

class SplashVC: UIViewController {
    // App init
    private var appInit = AppInit()
    
    // layout size manager
    var sizeManager:FMSizeManager? = nil;
    
    // loading animated view
    let splashLoadingAnimation = FMLottieAnimatedView(withLottieFile: K.LottieFiles.splashSpinner, withAnimationSpeed: 1.6);
    
    override func viewDidLoad() {
        // setup layout manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width, withHeightWidth: self.view.safeAreaLayoutGuide.layoutFrame.height);
        
        super.viewDidLoad()
        appInit.delegate = self
        
        self.view.backgroundColor = .systemBackground
       
        // show loading indicator
        self.setupLoadingIndicatorLayout();
        
        //TODO: Check if user is signed in
        appInit.isUserSignedIn()
        
    }
    
    
    //MARK: - Hide NavBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    //MARK: - Navigate User
    
    /// - Description: This method navigates user based on if they are logged in or not
    private func navigateUser(isUser loggedIn: Bool) {
        
            if (loggedIn){
                // navigate to user home
                self.loadHomeRootController()
            }else{
                // triger the AuthRootController
                self.loadAuthRootController()
            }
            
            
        }
          
    
    
    
    
    
    //MARK: - Setup Splash Indicator Layout
    private func setupLoadingIndicatorLayout(){
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
    private func loadAuthRootController(){
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        let onboardingCollectionVC = OnboardingCollectionVC(collectionViewLayout: layout);
        let onBoardingRootController = UINavigationController(rootViewController: onboardingCollectionVC);
        onBoardingRootController.modalPresentationStyle = .fullScreen
        self.present(onBoardingRootController, animated: true);
        
    }
    
    //MARK: - Home Root Controller
    private func loadHomeRootController(){
        let homeVC = HomeVC()
        let root = UINavigationController(rootViewController: homeVC);
        root.modalPresentationStyle = .fullScreen
        self.present(root, animated: true)
    }
    
    
    
    
    
}

extension SplashVC:AppInitDelegate{
    func authenticationComplete(with result: Bool) {
        DispatchQueue.main.async {
            self.navigateUser(isUser: result)
        }
    }
    
    
}

