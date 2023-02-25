//
//  FMFirebase.swift
//  FoodMIMA
//  Firebase code
//  Created by Johnson Olusegun on 2/24/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// TODO: FIX AND CLEAN UP

//MARK: - Protocol
protocol FMFirebaseDelegete {
    func requestStarted()
    func requestComplete()
    func errorOccured(with message:String)
    func requestSuccessful()
    
}


struct FMFirebase {
    var delegate:FMFirebaseDelegete?
    
    private let db = Firestore.firestore()
    
    
    //MARK: - Create new Account
    
    /// - Parameters: email: String, password: String, fullname: String
    func createNewAccount(withEmail email:String, and password:String, for fullname: String){
        // start request
        delegate?.requestStarted()
        // delay for 3 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                // handle error
                if let error = error {
                    delegate?.requestComplete()
                    delegate?.errorOccured(with: error.localizedDescription)
                    return
                }
                
                // if there is no user return
                guard let user = authResult?.user else {
                    delegate?.requestComplete()
                    delegate?.errorOccured(with: "Unknown error occurred!")
                    return
                }
                
                // create a new user account
                db.collection(K.Firebase.UserCollection.collectionName).document(user.uid).setData([
                    K.Firebase.UserCollection.email:email,
                    K.Firebase.UserCollection.fullName:fullname,
                ]) { err in
                    if let _ = err {
                        delegate?.errorOccured(with: "Unknown error occurred!")
                    } else {
                        delegate?.requestSuccessful()
                    }
                }
                
               
                // send confirmation email to the user
                Auth.auth().currentUser?.sendEmailVerification { error in
                    //handle the error
                    if let _ = error {
                        //TODO: Delete user account and return
                    }
                }
                
            }
            
            delegate?.requestComplete()
            
        }
        
    }
    //MARK: - Login
    func signInUser(withEmail email:String, and password:String){
        
        // start request
        delegate?.requestStarted()
        // delay for 3 sec so loading indicator will be visible
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                // handle error
                if let _ = error {
                    delegate?.requestComplete()
                    delegate?.errorOccured(with: "The email or password you entered is incorrect.")
                    return
                }
                
                // if there is no user return
                guard let _ = authResult?.user else {
                    delegate?.requestComplete()
                    delegate?.errorOccured(with: "Unknown error occurred!")
                    return
                }
                // update UserDefaults
                UserDefaults.standard.set(true, forKey: K.General.isUserLoggedIn)
                
                delegate?.requestSuccessful()
                
            }
            
            delegate?.requestComplete()
            
        }
        
        
    }
    
    // TODO: FIX AND CLEAN UP
    
    //MARK: - Log out
    func logUserOut(){
        delegate?.requestStarted()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                delegate?.requestSuccessful()
            } catch  {
                //print("Error signing out: %@", signOutError)
                delegate?.errorOccured(with: "Error signing out")
            }
            
            
            delegate?.requestComplete()
            
        }
        
    }
    
    
    
    
    
    
    
}


