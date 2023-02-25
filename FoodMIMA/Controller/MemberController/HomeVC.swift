//
//  HomeVC.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/24/23.
//

import UIKit

class HomeVC: UIViewController {
    var firebase = FMFirebase()
    
    // signup button
    private let logout = FMButton(title: "Logout")

    override func viewDidLoad() {
        super.viewDidLoad()
        firebase.delegate = self
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        
       
        
        self.view.addSubview(logout)
        logout.setTitle("Logout", for: .normal)
        logout.tintColor = .white
        logout.translatesAutoresizingMaskIntoConstraints = false
        logout.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.logout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            self.logout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            self.logout.heightAnchor.constraint(equalToConstant: 45),
            self.logout.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.logout.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        ])
        
        
    }
    
    // test
    @objc private func handleLogout(){
        firebase.logUserOut()
    }
    
    
    

  

}
// test
extension HomeVC:FMFirebaseDelegete {
    func requestStarted() {
        
    }
    
    func requestComplete() {
        
    }
    
    func errorOccured(with message: String) {
        FMAlert.showFirebaseErrorAlert(on: self, with:message)
    }
    
    func requestSuccessful() {
        DispatchQueue.main.async {
            let splashScreen = SplashVC()
            self.navigationController?.pushViewController(splashScreen, animated: false)
        }
    }
    
    
}
