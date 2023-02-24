//
//  SignUpVC.swift
//  FoodMIMA
//  Created by Johnson Olusegun on 2/21/23.
//

import UIKit

class SignupVC: UIViewController {
    
    // loading animated view
    let loadingAnimation = FMLottieAnimatedView(withLottieFile: K.LottieFiles.loadingSpinner, withAnimationSpeed: 1.6);
    
    // layout size manager
    private var sizeManager:FMSizeManager? = nil;
    // scroll view content size
    private lazy var contentSize:CGSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: (view.safeAreaLayoutGuide.layoutFrame.height - (navigationController?.navigationBar.frame.maxY ?? 0.0)) + 10)
    
    // scrollview
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.frame = view.bounds
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.contentSize = self.contentSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = .flexibleWidth
        scrollView.backgroundColor = .systemBackground
        scrollView.scrollsToTop = true
        scrollView.keyboardDismissMode = .interactiveWithAccessory
        
        return scrollView;
    }()
    
    // containerview
    private lazy var containerView:UIView = {
        let containerView = UIView()
        containerView.frame.size = self.contentSize
        containerView.backgroundColor = .systemBackground;
        return containerView;
    }()
    
    // auth header
    private let authHeader = FMAuthHeader(title: "Sign up", imageName: K.Images.Auth.signup);
    
    // stack view for text fields
    private let authTextFieldStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView;
    }()
    
    
    
    //TODO: Format Mobile Input
    // Text fields
    let userEmailField:FMUITextField = FMUITextField(input: .email, placeholder: "Email Address")
    let userFullnameField:FMUITextField = FMUITextField(input: .text, placeholder: "Full Name")
    let userPasswordField:FMUITextField = FMUITextField(input: .password, placeholder: "Password")
    
    
    // privacy and condition
    let privacyAndConditionTextView:UITextView = {
        let atrributes = [NSAttributedString.Key.font:UIFont.getRegularFont(size: 12)]
        var attributedString = NSMutableAttributedString(string: "By creating an account, you have agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy", attributes: atrributes)
        attributedString.addAttribute(.link, value: "terms://termsAndCondition", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        // modify UITextView
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor:UIColor(named: K.Colors.accentColor)!]
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .label
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.attributedText = attributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textView;
    }()
    
    // signup button
    private let signupButton = FMButton(title: "Create Account")
    
    // privacy and condition
    private let loginLink:UITextView = {
        let atrributes = [NSAttributedString.Key.font:UIFont.getRegularFont(size: 15)]
        var attributedString = NSMutableAttributedString(string: "Joined us before? Login", attributes: atrributes)
        attributedString.addAttribute(.link, value: "login://loginScreen", range: (attributedString.string as NSString).range(of: "Login"))
        
        // modify UITextView
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor:UIColor(named: K.Colors.accentColor)!]
        textView.backgroundColor = .clear
        textView.textColor = .label
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.attributedText = attributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textView;
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup size manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width, withHeightWidth: self.view.safeAreaLayoutGuide.layoutFrame.height);
        // set background color
        self.view.backgroundColor = .systemBackground;
        // setup scrollView layout
        self.setupScrollViewLayout()
        // auth header layout
        self.setupAuthHeaderLayout()
        // set up text stack view
        self.setupTextInputStackViewLayout()
        // privacy and terms layout
        self.setupPrivacyTermsAndConditionLayout()
        // loading indicator
        self.setupLoadingIndicatorLayout()
        // bottom footer layout [button and Link]
        self.setupAuthFooterLayout()
        
        // additional functions
        // tap gesture
        self.hideKeyboardWhenViewIsTapped()
        // adjust the scroll view when keyboard is present
        self.setupKeyboardNotificationObserver()
        
    }
    //MARK: - Show the NavBar
    override func viewWillAppear(_ animated: Bool) {
        // remove the title text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - Hide the NavBAr
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    //MARK: - Handle Keyboard notification
    private func setupKeyboardNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(_ notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            let edgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = edgeInsets
        }
    }
    
    @objc private func keyboardDidHide(_ notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let edgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height * -1, right: 0.0)
            scrollView.contentInset = edgeInsets
        }
    }
    
    //MARK: - Hide keyboard with gesture recognizer
    private func hideKeyboardWhenViewIsTapped(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoardOnViewTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc private func hideKeyBoardOnViewTap(_ recognizer:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    
    
    
    //MARK: - Set up scroll view
    func setupScrollViewLayout(){
        self.view.addSubview(scrollView);
        scrollView.addSubview(containerView);
    }
    
    
    //MARK: - Setup Auth Screen Header
    func setupAuthHeaderLayout(){
        containerView.addSubview(authHeader);
        authHeader.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            authHeader.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: sizeManager?.moderateScale(size: 50) ?? 50),
            authHeader.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: sizeManager?.moderateScale(size: -40) ?? -40),
            authHeader.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: sizeManager?.moderateScale(size: 40) ?? 40),
            authHeader.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.35)
            
        ])
        
        
    }
    
    //MARK: - Text input stack view
    func setupTextInputStackViewLayout(){
        containerView.addSubview(authTextFieldStackView)
        // setup delegate
        userEmailField.delegate = self
        userFullnameField.delegate = self
        userPasswordField.delegate = self
        
        // stackView subViews
        authTextFieldStackView.addArrangedSubview(userEmailField)
        authTextFieldStackView.addArrangedSubview(userFullnameField)
        authTextFieldStackView.addArrangedSubview(userPasswordField)
        
        
        
        NSLayoutConstraint.activate([
            authTextFieldStackView.topAnchor.constraint(equalTo: self.authHeader.bottomAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            authTextFieldStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            authTextFieldStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            authTextFieldStackView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.2)
            
        ])
        
        
    }
    
    //MARK: - Privacy and Terms Layout
    func setupPrivacyTermsAndConditionLayout(){
        containerView.addSubview(privacyAndConditionTextView)
        privacyAndConditionTextView.delegate = self
        
        NSLayoutConstraint.activate([
            privacyAndConditionTextView.topAnchor.constraint(equalTo: self.authTextFieldStackView.bottomAnchor, constant: sizeManager?.moderateScale(size: 2) ?? 2),
            privacyAndConditionTextView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            privacyAndConditionTextView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            
        ])
    }
    
    //MARK: - Loading Indicator Layout
    func setupLoadingIndicatorLayout(){
        containerView.addSubview(loadingAnimation)
        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation.isHidden = false
        
        NSLayoutConstraint.activate([
            loadingAnimation.topAnchor.constraint(equalTo: self.privacyAndConditionTextView.bottomAnchor, constant: sizeManager?.moderateScale(size: 15) ?? 15),
            loadingAnimation.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 40) ?? 40),
            loadingAnimation.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 40) ?? 40),
            loadingAnimation.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    //MARK: - Setup Bottom Button and Link Layout
    func setupAuthFooterLayout(){
        self.containerView.addSubview(signupButton)
        self.containerView.addSubview(loginLink)
        //setup button and link
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        loginLink.translatesAutoresizingMaskIntoConstraints = false
        // delegate
        loginLink.delegate = self
        // set up signup button action
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: self.loadingAnimation.bottomAnchor, constant:sizeManager?.moderateScale(size: 15) ?? 15),
            signupButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            signupButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            signupButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07),
            
            
            loginLink.topAnchor.constraint(equalTo: self.signupButton.bottomAnchor, constant:sizeManager?.moderateScale(size: 5) ?? 5),
            loginLink.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            loginLink.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.05)
            
        ])
        
    }
    
    //MARK: - Signup Button Clicked
    @objc private func signupButtonClicked(){
        // values
        guard let email = userEmailField.text else { return }
        guard let fullName = userFullnameField.text else { return }
        guard let password = userPasswordField.text else { return }
        
        
        if(FMValidator.isEmpty(with: email)){
            FMAlert.showEmptyFieldAlert(on: self, forFieldName: "email address")
        }
        else if (FMValidator.isInvalidEmail(with: email)){
            FMAlert.showInvalidEmailAlert(on: self)
        }
        else if(FMValidator.isEmpty(with: fullName)){
            FMAlert.showEmptyFieldAlert(on: self, forFieldName: "full name")
        }
        else if (FMValidator.isInvalidFullName(with: fullName)){
            FMAlert.showInvalidFullNameAlert(on: self)
        }
        else if(FMValidator.isEmpty(with: password)){
            FMAlert.showEmptyFieldAlert(on: self, forFieldName: "password")
        }
        else if(FMValidator.isInvalidPassword(with: password)){
            FMAlert.showInvalidPasswordAlert(on: self)
        }
        else{
            // create user account
            
        }
        
        
        
        
    
        
        
        
        //        let welcomeOnboardVC = WelcomeOnboard()
        //        navigationController?.pushViewController(welcomeOnboardVC, animated: true)
        
    }
    
    
    
    
}


//MARK: - UITextViewDelegate
extension SignupVC : UITextViewDelegate{
    // handle Terms and Condition Clicked
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            // load up web view or navigate
            print("Terms and Conditions Button Clicked")
        }else if URL.scheme == "privacy" {
            print("Privacy Button Clicked")
        }
        // navigate to login screen
        else if URL.scheme == "login" {
            let signinVC = SigninVC()
            self.navigationController?.pushViewController(signinVC, animated: true);
        }
        
        return false
    }
    
    
    //
    func textViewDidChange(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}


//MARK: - UITextFieldDelegate and Keyboard settings
extension SignupVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            userFullnameField.becomeFirstResponder()
        }
        else if textField == userFullnameField {
            userPasswordField.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    
    
    
    
}




