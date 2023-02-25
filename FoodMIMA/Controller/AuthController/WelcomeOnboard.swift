//
//  WelcomeOnboard.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/23/23.
//

import UIKit


class WelcomeOnboard: UIViewController {
    
    // layout size manager
    var sizeManager:FMSizeManager? = nil;
    
    // loading animated view
    let welcomeOnboardAnimation = FMLottieAnimatedView(withLottieFile: K.LottieFiles.welcomeOnboard, withAnimationSpeed: 1.6);
    
    //  welcomeOnboardText
    let welcomeOnboardText:UITextView = {
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        var attributedString = NSMutableAttributedString()
        
        let headingTextAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.foregroundColor:UIColor.label, NSAttributedString.Key.font: UIFont.getHeavyFont(size: 30)]
        let subHeadingTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel, NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.font: UIFont.getRegularFont(size: 12)]
        
        let headingText = NSAttributedString(string: "Congrats!", attributes: headingTextAttributes)
        let subHeading = NSAttributedString(string: "\nWelcome onboard we've send you a confirmation email to verify your account!", attributes:subHeadingTextAttributes)
        
        attributedString.append(headingText)
        attributedString.append(subHeading)
        

        paragraphStyle.alignment = .center
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.attributedText = attributedString
        return textView;
    }()
    
    // login button
    let loginButton:FMButton = FMButton(title: "Login")
    
    
    
    override func viewDidLoad() {
        // setup layout manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width, withHeightWidth: self.view.safeAreaLayoutGuide.layoutFrame.height);
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // setup header animation
        self.setupHeaderAnimationLayout()
        // set up header text
        self.setupHeaderTextLayout()
        // login button
        self.setupLoginButtonLayout()
        
        
    }
    
    //MARK: - setup header animation
    func setupHeaderAnimationLayout(){
        self.view.addSubview(welcomeOnboardAnimation)
        welcomeOnboardAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.welcomeOnboardAnimation.topAnchor.constraint(equalTo: view.topAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            self.welcomeOnboardAnimation.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 400) ?? 400),
            self.welcomeOnboardAnimation.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 400) ?? 400),
            self.welcomeOnboardAnimation.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
          
        ])
    }
    
    //MARK: - setup header text
    func setupHeaderTextLayout(){
        self.view.addSubview(welcomeOnboardText)
        welcomeOnboardText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.welcomeOnboardText.topAnchor.constraint(equalTo: welcomeOnboardAnimation.bottomAnchor, constant: sizeManager?.moderateScale(size: 5) ?? 5),
            self.welcomeOnboardText.trailingAnchor.constraint(equalTo:self.view.trailingAnchor,constant: sizeManager?.moderateScale(size: -50) ?? -50),
            self.welcomeOnboardText.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: sizeManager?.moderateScale(size: 50) ?? 50),
            
            
        ])
    }
    
    //MARK: - Navigate to login screen
    func setupLoginButtonLayout(){
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(navigateToLoginScreen), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: welcomeOnboardText.bottomAnchor, constant: sizeManager?.moderateScale(size: 20) ?? 20),
            self.loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: sizeManager?.moderateScale(size: -50) ?? -50),
            self.loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sizeManager?.moderateScale(size: 50) ?? 50),
            self.loginButton.heightAnchor.constraint(equalToConstant: sizeManager?.moderateScale(size: Double(K.General.buttonHeight)) ?? Double(K.General.buttonHeight))
            
        ])
    }
    
    //MARK: - Login Button Action
    @objc private func navigateToLoginScreen(){
        let loginVC = SigninVC()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
        
    
}
