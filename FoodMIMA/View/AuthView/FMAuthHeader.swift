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
    private let subHeadingText = FMUILabel(labelType: .primary, withTextAlignment: .left)
    
    

    required init(title:String, imageName:String, withTwoHeading showWithTwoHeading:Bool = false, secondHeadingText secondTitle:String = "Sub Heading"){
        super.init(frame: .zero)
      
        //setup auth image
        self.setupAuthImage(imageName: imageName, withTwoHeading: showWithTwoHeading)
        // setup auth text
        self.setupAuthHeading(title: title, secondTitle: secondTitle, withTwoHeading: showWithTwoHeading);

    
    }
    
    
    //MARK: - setup auth image
    func setupAuthImage(imageName:String, withTwoHeading:Bool){
        self.addSubview(imageView)
        imageView.image = UIImage(named: imageName)!
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor ),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: withTwoHeading ? 0.7 : 0.8)
        ])
        
    }
    
    //MARK: - setup auth heading
    func setupAuthHeading(title:String, secondTitle:String, withTwoHeading:Bool){
        // if with two heading is false
        if(!withTwoHeading){
            self.addSubview(textHeading)
            self.textHeading.translatesAutoresizingMaskIntoConstraints = false
            
            textHeading.text = title
            textHeading.font = .getDemiBoldFont(size: 32)
            
            
            NSLayoutConstraint.activate([
                textHeading.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
                textHeading.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                textHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                textHeading.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
            ])
        }
        
        else {
            // create a new heading
             let newHeading:UITextView = {
                let atrributes = [NSAttributedString.Key.font:UIFont.getDemiBoldFont(size: 32)]
                 let attributedString = NSMutableAttributedString(string: "\(title)\n\(secondTitle)", attributes: atrributes)
                // modify UITextView
                let textView = UITextView()
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
            
            
            self.addSubview(newHeading)
            NSLayoutConstraint.activate([
                newHeading.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
                newHeading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
                newHeading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                newHeading.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3)
            ])
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
