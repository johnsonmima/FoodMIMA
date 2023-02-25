//
//  AppInit.swift
//  FoodMIMA
//
//  Created by Johnson Olusegun on 2/24/23.
//

import Foundation
import FirebaseAuth


//TODO: FIX to make use of callback

protocol AppInitDelegate {
    func authenticationComplete(with result:Bool)
}

struct AppInit {
    var delegate:AppInitDelegate?
        
     func isUserSignedIn(){
        
        let isSignedIn = UserDefaults.standard.bool(forKey: K.General.isUserLoggedIn);
        // if there is a saved key in user defaut then validate the
        // user is actually signed in
         DispatchQueue.main.asyncAfter(deadline: .now() + Double(K.General.SplashDelayTime)){
             if(isSignedIn){
                 if Auth.auth().currentUser != nil {
                     //return true;
                     delegate?.authenticationComplete(with: true)
                 } else {
                     // No user is signed in.
                     // update user default
                     UserDefaults.standard.set(false, forKey: K.General.isUserLoggedIn)
                     //return false
                     delegate?.authenticationComplete(with: false)
                 }
             }
             else{
                 
                 // if isSignedIn = false
                 delegate?.authenticationComplete(with: false)
             }
         }
        
        
    }
        
        
    }
    
