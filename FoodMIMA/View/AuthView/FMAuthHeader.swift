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
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: withTwoHeading ? 0.7 : 0.75)
        ])
        
    }
    
    //MARK: - setup auth heading
    func setupAuthHeading(title:String, secondTitle:String, withTwoHeading:Bool){
        
        let headingTextView:UITextView = {
            
            let paragraphStyle = NSMutableParagraphStyle()
            
            let attributedString = NSMutableAttributedString()
            
            let headingTextAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.foregroundColor:UIColor.label, NSAttributedString.Key.font: UIFont.getDemiBoldFont(size: 32)]
            let subHeadingTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.label, NSAttributedString.Key.paragraphStyle:paragraphStyle, NSAttributedString.Key.font: UIFont.getDemiBoldFont(size: 32)]
                
            let headingText = NSAttributedString(string: title, attributes: headingTextAttributes)
            attributedString.append(headingText)
            
            // if withTwoHeading
            if(withTwoHeading){
                let subHeading = NSAttributedString(string: "\n\(secondTitle)", attributes:subHeadingTextAttributes)
                attributedString.append(subHeading)
            }
            

            paragraphStyle.alignment = .left
            let textView = UITextView()
            textView.backgroundColor = .systemBackground
            textView.isEditable = false
            textView.isSelectable = false
            textView.isScrollEnabled = false
            textView.attributedText = attributedString
            return textView;
        }()
        
        
            self.addSubview(headingTextView)
            headingTextView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                headingTextView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
                headingTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                headingTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                headingTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: withTwoHeading ? 0.3 : 0.25)
            ])
        }
        
        
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
