//
//  Auth.swift
//  WooShot
//
//  Created by Mathieu Vandeginste on 04/12/2016.
//  Copyright © 2016 WooShot. All rights reserved.
//

import Foundation
import FirebaseAuth
import FacebookCore


class FirebaseUserManager: UserProtocol {
    
    private var currentUser: User?
    
    var uid: String {
        return FIRAuth.auth()!.currentUser!.uid
    }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    //setters
    func setCurrentUser(displayName: String, isMale: Bool, lovesMen: Bool, lovesWomen: Bool) {
        self.currentUser = User(displayName: displayName, isMale: isMale, lovesMale: lovesMen, lovesFemale: lovesWomen)
    }
    
    
    
    func updateDisplayName(displayName: String) {
        if let user = self.currentUser {
            user.displayName = displayName
            print("new name = \(displayName)")
        }
    }
    
    func updateSex(isMale: Bool) {
        if let user = self.currentUser {
            user.isMale = isMale
        }
    }
    
    func updatePrefMale(lovesMen: Bool) {
        if let user = self.currentUser {
            user.lovesMale = lovesMen
        }
    }
    
    func updatePrefFemale(lovesWomen: Bool) {
        if let user = self.currentUser {
            user.lovesFemale = lovesWomen
        }
    }

    
    
    func facebookLogin(token: AccessToken, callback: @escaping (_ user: FIRUser? , _ error: Error?) -> ()) {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            callback(user, error)
        })
        
    }
    
    func emailLogin() {
        
    
    }
    
    func logout(callback: (_ error: Error?)-> ()) {
        do {
            try FIRAuth.auth()?.signOut()
            callback(nil)
        } catch {
            callback(error)
        }
    }
    
    func signOff(callback: @escaping (_ error: Error?)-> ()) {
        let user = FIRAuth.auth()?.currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                callback(error)
            } else {
                // Account deleted.
                callback(nil)
            }
        }
    }
    
    
    
}
