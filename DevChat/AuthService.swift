//
//  AuthService.swift
//  DevChat
//
//  Created by Richard Eccles on 1/7/17.
//  Copyright © 2017 Richard Eccles. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
        //if there is an error
            if error != nil {
                //check the error code
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    if errorCode == .errorCodeUserNotFound {
                        //if user is not found then sign in
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                //show error to user
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            }
                            else {
                                if user?.uid != nil {
                                    //save to firebase db
                                    DataService.instance.saveUser(uid: user!.uid)
                                    //Sign In
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            //show error to user
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        }
                                        else {
                                            //we have successfully logged in
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                            
                        })
                    }
                }
                else {
                    //handle all other errors
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            }
            else {
                //successfully logged in
                onComplete?(nil, user)
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch (errorCode) {
            case .errorCodeInvalidEmail:
                //print
                onComplete?("Invalid email address", nil)
                break
            case .errorCodeWrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email already in use", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
                break
            }
        }
    }
}
