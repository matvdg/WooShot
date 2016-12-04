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
    
    func facebookConnect(token: AccessToken, callback: @escaping (_ user: FIRUser? , _ error: Error?) -> ()) {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: token.authenticationToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            callback(user, error)
        })
        
    }
    
    func emailConnect() {
        
    }
    
}
