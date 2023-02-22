//
//  OnboardingCollectionViewCell.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    var data:OnBoardingPageModel? {
        didSet{
            guard let unwrapedData = data else { return }
            cellImageView.image = UIImage(named: unwrapedData.imageName);
            cellTitleLabel.text = unwrapedData.title;
            cellTitleLabel.font = UIFont(name: "AvenirNext-Heavy", size: sizeManager?.fontSize(size: 24) ?? 24);
            cellSubtitleLabel.text = unwrapedData.subTitle;
            cellSubtitleLabel.font = UIFont(name: "AvenirNext-Regular", size: sizeManager?.fontSize(size: 14) ?? 14);
            
            
            
        }
    }
    
    // Cell ImageView
    private let cellImageView:UIImageView = {
        let imageView = UIImageView();
        imageView.contentMode = .scaleAspectFit;
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        
        return imageView;
    }()
    
    private let cellTitleLabel:UILabel = {
        let textLebel = UILabel();
        textLebel.textColor = .label
        textLebel.textAlignment = .left
        textLebel.numberOfLines = 0
        textLebel.translatesAutoresizingMaskIntoConstraints = false;
        return textLebel;
    }()
    
    private let cellSubtitleLabel:UILabel = {
        let textLebel = UILabel();
        textLebel.textColor = .secondaryLabel
        textLebel.textAlignment = .left
        textLebel.numberOfLines = 0
        textLebel.translatesAutoresizingMaskIntoConstraints = false;
        return textLebel;
    }()
    
    
    // layout size manager
   private var sizeManager:FMSizeManager? = nil;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
       
      
        // setup size manager before calling view did load
        sizeManager = FMSizeManager(withFrameWidth: self.frame.width, withHeightWidth: self.frame.height);

        // set backgroundColor
        self.backgroundColor = .systemBackground;
       // set up Cell Image
        self.setupCellImageLayout();
        // setup text content
        self.setupCellTextContentLayout();
    }
    
    //MARK: - setupCellImageLayout
    func setupCellImageLayout(){
        self.addSubview(cellImageView);
       
        NSLayoutConstraint.activate([
            cellImageView.widthAnchor.constraint(equalToConstant: sizeManager?.horizontalScale(size: 350) ?? 350),
            cellImageView.heightAnchor.constraint(equalToConstant: sizeManager?.verticalScale(size: 350) ?? 350),
            cellImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: sizeManager?.moderateScale(size: 40) ?? 40),
            cellImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
       
    }
    
    //MARK: - Setup Text Title and Sub Title
    func setupCellTextContentLayout(){
        self.addSubview(cellTitleLabel);
        self.addSubview(cellSubtitleLabel);
        
        NSLayoutConstraint.activate([
            cellTitleLabel.topAnchor.constraint(equalTo: self.cellImageView.bottomAnchor, constant: sizeManager?.moderateScale(size: 60) ?? 60),
            cellTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: sizeManager?.moderateScale(size: -30) ?? -30),
            cellTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sizeManager?.moderateScale(size: 30) ?? 30),
            cellTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            cellSubtitleLabel.topAnchor.constraint(equalTo: self.cellTitleLabel.bottomAnchor, constant: sizeManager?.moderateScale(size: 10) ?? 10),
            cellSubtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: sizeManager?.moderateScale(size: -30) ?? -30),
            cellSubtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sizeManager?.moderateScale(size: 30) ?? 30),
            cellSubtitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
