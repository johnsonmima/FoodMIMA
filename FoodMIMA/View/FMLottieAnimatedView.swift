//
//  FMAnimatedView.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/20/23.
//

import UIKit
import Lottie

class FMLottieAnimatedView: UIView {
    private var animationView: LottieAnimationView;
    
    
    required init(withLottieFile fileName:String, withAnimationSpeed speed:Double = 0.5 ) {
        animationView = .init(name: fileName);
       
        // super
        super.init(frame: .zero)
        // addition setup
        animationView.frame = self.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = speed
        animationView.play()
    
       
        self.setUpAnimatedView()
        
    }
    
    
    func setUpAnimatedView(){
        self.addSubview(animationView);
        animationView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: self.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            animationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            animationView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
