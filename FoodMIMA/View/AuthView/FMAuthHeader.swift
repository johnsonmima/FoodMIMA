//
//  FMAuthHeader.swift
//  FoodMIMA
//  this class is a reusable header for all auth screens
//  Created by Johnson Olusegun on 2/21/23.
//

import UIKit

class FMAuthHeader: UIView {
    
    // layout size manager
   private var sizeManager:FMSizeManager? = nil;
    
    // auth Image
    private let imageView = FMImageView()
    // auth text
    private let textHeading = FMUILabel(labelType: .primary, withTextAlignment: .left)

    required init(title:String, imageName:String){
        super.init(frame: .zero)
      
        //setup auth image
        self.setupAuthImage(imageName: imageName)
        // setup auth text
        self.setupAuthHeading(title: title);
    }
    
    
    //MARK: - setup auth image
    func setupAuthImage(imageName:String){
        self.addSubview(imageView)
        imageView.image = UIImage(named: imageName)!
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor ),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
    }
    
    //MARK: - setup auth heading
    func setupAuthHeading(title:String){
        self.addSubview(textHeading)
        self.textHeading.translatesAutoresizingMaskIntoConstraints = false

        textHeading.text = title
        textHeading.font = UIFont(name: "AvenirNext-DemiBold", size: 32);

        
        NSLayoutConstraint.activate([
            textHeading.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
            textHeading.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textHeading.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
