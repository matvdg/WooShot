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

class Auth {
    
    let uid = FIRAuth.auth()?.currentUser?.providerID
    
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
