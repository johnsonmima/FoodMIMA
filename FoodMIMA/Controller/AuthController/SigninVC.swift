//
//  SigninVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/23/23.
//

import UIKit

class SigninVC: UIViewController {
    // firebase
    private var firebase = FMFirebase()
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
    private let authHeader = FMAuthHeader(title: "Login", imageName: K.Images.Auth.signin);
    
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
    let userPasswordField:FMUITextField = FMUITextField(input: .password, placeholder: "Password")
    
    // forgot bottom Stack View
    // stack view for text fields
    private let forgotPasswordLinkStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView;
    }()
    
    // forgot password
    private let forgotPasswordLink:UITextView = {
        let atrributes = [NSAttributedString.Key.font:UIFont.getDemiBoldFont(size: 14)]
        var attributedString = NSMutableAttributedString(string: "Forgot Password?", attributes: atrributes)
        attributedString.addAttribute(.link, value: "forgotPassword://forgotPasswordScreen", range: (attributedString.string as NSString).range(of: "Forgot Password?"))
        
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
    
    
    
    // register button
    private let signinButton = FMButton(title: "Login")
    
    // privacy and condition
    private let registerLink:UITextView = {
        let atrributes = [NSAttributedString.Key.font:UIFont.getRegularFont(size: 14)]
        var attributedString = NSMutableAttributedString(string: "New to \(K.General.AppName)? Register", attributes: atrributes)
        attributedString.addAttribute(.link, value: "register://registerScreen", range: (attributedString.string as NSString).range(of: "Register"))
        
        // modify UITextView
        let textView = UITextView()
        textView.linkTextAttributes = [.foregroundColor:UIColor(named: K.Colors.accentColor)!]
        textView.textAlignment = .left
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
        //delegate
        firebase.delegate = self
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
        // forgot password layout
        self.setupForgotPasswordLayout()
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
    //MARK: - Hide NavBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - Show NavBar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // remove the title text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isHidden = false
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
        userPasswordField.delegate = self
        
        // stackView subViews
        authTextFieldStackView.addArrangedSubview(userEmailField)
        authTextFieldStackView.addArrangedSubview(userPasswordField)
        
        
        
        NSLayoutConstraint.activate([
            authTextFieldStackView.topAnchor.constraint(equalTo: self.authHeader.bottomAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            authTextFieldStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            authTextFieldStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            authTextFieldStackView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.15)
            
        ])
        
        
    }
    
    //MARK: - Forgot Password Layout
    func setupForgotPasswordLayout(){
        containerView.addSubview(forgotPasswordLinkStackView)
        forgotPasswordLinkStackView.addArrangedSubview(UIView())
        forgotPasswordLinkStackView.addArrangedSubview(forgotPasswordLink)
        forgotPasswordLink.delegate = self
        
        NSLayoutConstraint.activate([
            forgotPasswordLinkStackView.topAnchor.constraint(equalTo: self.authTextFieldStackView.bottomAnchor, constant: sizeManager?.moderateScale(size: 2) ?? 2),
            forgotPasswordLinkStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            forgotPasswordLinkStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            
        ])
    }
    
    //MARK: - Loading Indicator Layout
    func setupLoadingIndicatorLayout(){
        containerView.addSubview(loadingAnimation)
        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation.isHidden = true
        
        NSLayoutConstraint.activate([
            loadingAnimation.topAnchor.constraint(equalTo: self.forgotPasswordLinkStackView.bottomAnchor, constant: sizeManager?.moderateScale(size: 15) ?? 15),
            loadingAnimation.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 40) ?? 40),
            loadingAnimation.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 40) ?? 40),
            loadingAnimation.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    //MARK: - Setup Bottom Button and Link Layout
    func setupAuthFooterLayout(){
        self.containerView.addSubview(signinButton)
        self.containerView.addSubview(registerLink)
        //setup button and link
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        registerLink.translatesAutoresizingMaskIntoConstraints = false
        // delegate
        registerLink.delegate = self
        // set up signup button action
        signinButton.addTarget(self, action: #selector(signinButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalTo: self.loadingAnimation.bottomAnchor, constant:sizeManager?.moderateScale(size: 15) ?? 15),
            signinButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            signinButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            signinButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07),
            
            
            registerLink.topAnchor.constraint(equalTo: self.signinButton.bottomAnchor, constant:sizeManager?.moderateScale(size: 5) ?? 5),
            registerLink.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            registerLink.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.05)
            
        ])
        
    }
    
    
    
    
    
    //MARK: - Signup Button Clicked
    @objc private func signinButtonClicked(){
        // values
        guard let email = userEmailField.text else { return }
        guard let password = userPasswordField.text else { return }
        
        
        if(FMValidator.isEmpty(with: email)){
            FMAlert.showEmptyFieldAlert(on: self, forFieldName: "email address")
        }
        else if (FMValidator.isInvalidEmail(with: email)){
            FMAlert.showInvalidEmailAlert(on: self)
        }
        
        else if(FMValidator.isEmpty(with: password)){
            FMAlert.showEmptyFieldAlert(on: self, forFieldName: "password")
        }
        else{
            // create user account
            firebase.signInUser(withEmail: email, and: password)
        }
        
        
    }
    
    
    
    
}

//MARK: - FMFirebaseDelegete
extension SigninVC:FMFirebaseDelegete {
    
    // show loading indicator
    func requestStarted() {
        DispatchQueue.main.async {
            self.loadingAnimation.isHidden = false;
            self.signinButton.isEnabled = false
        }
    }
    // hide loading indicator
    func requestComplete() {
        DispatchQueue.main.async {
            self.loadingAnimation.isHidden = true;
            self.signinButton.isEnabled = true
            
        }
    }
    
    // error occured
    func errorOccured(with message: String) {
        FMAlert.showFirebaseErrorAlert(on: self, with:message)
    }
    // request successful
    func requestSuccessful() {
        // back to splash screen
        //        let homeVC = HomeVC()
        //        navigationController?.pushViewController(homeVC, animated: false)
        DispatchQueue.main.async {
            let splashScreen = SplashVC()
            self.navigationController?.pushViewController(splashScreen, animated: false)
        }
        
        
    }
    
    
}

//MARK: - UITextViewDelegate
extension SigninVC : UITextViewDelegate{
    // handle Terms and Condition Clicked
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "register" {
            let signupVC = SignupVC()
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
        else if URL.scheme == "forgotPassword" {
            let forgotPasswordVC = ForgotPasswordVC()
            self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        }
        
        return false
    }
    
    
    // textViewDidChange
    func textViewDidChange(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}


//MARK: - UITextFieldDelegate and Keyboard settings
extension SigninVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            userPasswordField.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    
    
    
    
}




