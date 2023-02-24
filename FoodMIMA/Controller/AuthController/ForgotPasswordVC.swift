//
//  ForgotPasswordVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/23/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
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
    private let authHeader = FMAuthHeader(title: "Forgot", imageName: K.Images.Auth.forgotPassword, withTwoHeading: true, secondHeadingText: "Password?");
    // sub heading
    private let subtitleLabel:UITextView = {
        let atrributes = [NSAttributedString.Key.font:UIFont.getRegularFont(size: 12), NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel ]
        let attributedString = NSMutableAttributedString(string: "Don't worry! it happens. Please enter the address associated with your account.", attributes: atrributes)
       // modify UITextView
       let textView = UITextView()
        textView.textAlignment = .left
       textView.backgroundColor = .clear
        textView.clipsToBounds = true
       textView.textColor = .label
       textView.isSelectable = true
       textView.isEditable = false
       textView.isScrollEnabled = false
       textView.attributedText = attributedString
       textView.translatesAutoresizingMaskIntoConstraints = false
       
       
       return textView;
   }()
    
    // Text fields
    let userEmailField:FMUITextField = FMUITextField(input: .email, placeholder: "Email Address")
    
    // register button
    private let submitButton = FMButton(title: "Submit")
    
    
    
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
        // set up sub header
        self.setupTextSubHeading()
        //setup email input layout
        self.setupEmailFieldLayout()
        // loading indicator
        self.setupLoadingIndicatorLayout()
        // bottom footer layout [button]
        self.setupForgotBtnSubmitLayout()
        
        // additional functions
        // tap gesture
        self.hideKeyboardWhenViewIsTapped()
        // adjust the scroll view when keyboard is present
        self.setupKeyboardNotificationObserver()
        
        
    }
    
   
    
    
    
    //MARK: - Handle Keyboard notification
    private func setupKeyboardNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(_ notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            let edgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 50, right: 0.0)
            scrollView.contentInset = edgeInsets
        }
    }
    
    @objc private func keyboardDidHide(_ notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let edgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardSize.height + 50) *  -1, right: 0.0)
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
            authHeader.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            authHeader.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: sizeManager?.moderateScale(size: -40) ?? -40),
            authHeader.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: sizeManager?.moderateScale(size: 40) ?? 40),
            authHeader.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.5)
            
        ])
        
        
    }
    
    
    //MARK: - setup sub heading
    func setupTextSubHeading(){
        self.containerView.addSubview(subtitleLabel)
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: self.authHeader.bottomAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: sizeManager?.moderateScale(size: -40) ?? -40),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: sizeManager?.moderateScale(size: 40) ?? 40),
           
        ])
    }
    
    //MARK: -Setup email field
    func setupEmailFieldLayout(){
        self.containerView.addSubview(userEmailField)
        self.userEmailField.translatesAutoresizingMaskIntoConstraints = false
        // setup delegate
        userEmailField.delegate = self


        NSLayoutConstraint.activate([
            userEmailField.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            userEmailField.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: sizeManager?.moderateScale(size: -40) ?? -40),
            userEmailField.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: sizeManager?.moderateScale(size: 40) ?? 40),
            userEmailField.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.06)

        ])


    }
    

    
    //MARK: - Loading Indicator Layout
    func setupLoadingIndicatorLayout(){
        containerView.addSubview(loadingAnimation)
        loadingAnimation.translatesAutoresizingMaskIntoConstraints = false
        loadingAnimation.isHidden = false

        NSLayoutConstraint.activate([
            loadingAnimation.topAnchor.constraint(equalTo: self.userEmailField.bottomAnchor, constant: sizeManager?.moderateScale(size: 15) ?? 15),
            loadingAnimation.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 40) ?? 40),
            loadingAnimation.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 40) ?? 40),
            loadingAnimation.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    // MARK: - Setup Bottom Button
    func setupForgotBtnSubmitLayout(){
        self.containerView.addSubview(submitButton)
        
        //setup button and link
        submitButton.translatesAutoresizingMaskIntoConstraints = false
   
        // set up signup button action
        submitButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: self.loadingAnimation.bottomAnchor, constant:sizeManager?.moderateScale(size: 15) ?? 15),
            submitButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -40),
            submitButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 40),
            submitButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.07),


        ])

    }
    
    //MARK: - Signup Button Clicked
    @objc private func submitButtonClicked(){
        print("Clicked")
    }
    
    
    
    
}




//MARK: - UITextFieldDelegate and Keyboard settings
extension ForgotPasswordVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            textField.resignFirstResponder()
        }
       
        return true
    }
    
    
    
    
    
    
}





