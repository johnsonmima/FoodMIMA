//
//  SignUpVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/21/23.
//

import UIKit

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set background color
        self.view.backgroundColor = .systemBackground;
        // setup navigation
        self.navigationItem.leftBarButtonItem?.tintColor = .green
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.navigationItem.leftBarButtonItem?.tintColor = .green
    }
    
    


  

}


extension UINavigationController {
    
    func changeBackButtonStyle(withSystemImage image:UIImage){
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName:"check");
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName:"check");
    }
    
}
