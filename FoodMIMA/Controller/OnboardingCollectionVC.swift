//
//  OnboardingVC.swift
//  FoodMIMA
//  On Bording collection VC
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit

class OnboardingCollectionVC: UICollectionViewController {
    // Screen Data
    private let pageData:[OnBoardingPageModel] = OnBoardingPageModelData.getAllScreenData();
    
    // layout size manager
    private var sizeManager:FMSizeManager? = nil;
    
    // skip btn
    private let skipButton:FMButton = FMButton(title: "Skip");
    private let getStartedButton:FMButton = FMButton(title: "Get Started");
    
    // page controller
    private lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl();
        pageControl.numberOfPages = pageData.count;
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = .secondaryLabel;
        pageControl.currentPageIndicatorTintColor = UIColor(named: K.Colors.accentColor);
        
        return pageControl;
    }()
    
    // this view is inserted in the satck view
    // so to push the contol and button to the
    // screen
    private let pageControlDividerView:UIView = {
        let dividerView = UIView()
        return dividerView;
    }()
    
    // page control stack view
    private let pageControlStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal;
        stackView.distribution = .fillEqually;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        return stackView;
    }()
    
    
    

    override func viewDidLoad() {
        // setup size manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.view.safeAreaLayoutGuide.layoutFrame.width, withHeightWidth: self.view.safeAreaLayoutGuide.layoutFrame.height);
        
        super.viewDidLoad();
        
        // enable paging to have page like attribute
        collectionView.isPagingEnabled = true;
        // hide scroll bar
        collectionView.showsHorizontalScrollIndicator = false;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: K.ReuseIdentifier.OnboardingCellIdentifier);
        
        // setup page controller stack view
        self.setupPageControllerStackViewLayout();
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // hide the navigation bar  
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false;
        // remove the title text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      
        
    }
    
    //MARK: - Setup Buttom Controller Layout
    func setupPageControllerStackViewLayout(){
        self.view.addSubview(pageControlStackView);
        // add targets
        getStartedButton.addTarget(self, action: #selector(skipOrGetstartedButtonPressed), for: .touchUpInside);
        skipButton.addTarget(self, action: #selector(skipOrGetstartedButtonPressed), for: .touchUpInside);
        // remove all subviews on each render
        pageControlStackView.subviews.forEach({ $0.removeFromSuperview()})
        
        // if last page present getstarted button
        if(pageControl.currentPage == pageData.count - 1){
            pageControlStackView.addArrangedSubview(pageControl);
            pageControlStackView.addArrangedSubview(pageControlDividerView);
            pageControlStackView.addArrangedSubview(getStartedButton);
        }else{
            
            pageControlStackView.addArrangedSubview(pageControl);
            pageControlStackView.addArrangedSubview(pageControlDividerView);
            pageControlStackView.addArrangedSubview(skipButton);
        }
        
        
        NSLayoutConstraint.activate([
            pageControlStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: sizeManager?.moderateScale(size: -30) ?? -30),
            pageControlStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: sizeManager?.moderateScale(size: 30) ?? 30),
            pageControlStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: sizeManager?.moderateScale(size: -30) ?? -30),
            pageControlStackView.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 45) ?? 45),
            
        ])
    }
    
    //MARK: - Controller Action
    // navigate to signup screen
    @objc private func skipOrGetstartedButtonPressed(){
        let signUpVC = SignupVC()
        navigationController?.pushViewController(signUpVC, animated: true);
    }
    
    
    
    
    
    
    
    
}



//MARK: - UICollectionViewDataSource
extension OnboardingCollectionVC{
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pageData.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReuseIdentifier.OnboardingCellIdentifier, for: indexPath) as! OnboardingCollectionViewCell
        
        // Configure the cell
        let currentData = pageData[indexPath.item];
        cell.data = currentData;
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // this method all us to update the page controller
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x;
        // return the current page
        pageControl.currentPage = Int(x / view.frame.width);
        // set the layout for every scroll
        self.setupPageControllerStackViewLayout()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingCollectionVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
    }
    
}

// MARK: UICollectionViewDelegate
extension OnboardingCollectionVC{
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
