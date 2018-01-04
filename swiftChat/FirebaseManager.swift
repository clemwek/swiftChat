//
//  FirebaseManager.swift
//  swiftChat
//
//  Created by Dhwty on 05/12/2017.
//  Copyright © 2017 Dhwty. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FirebaseManager: NSObject {
    static let databaseRef = Database.database().reference()
    static var currentUserId:String = ""
    static var currentUser: FirebaseAuth.User? = nil
    
    static func Login(email:String, password:String, completion: @escaping (_ success:Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            } else {
                guard let user = user else { return }
                currentUser = user
                completion(true)
            }
        })
    }
    
    static func CreateAccount(email: String, password: String, username: String, completion: @escaping(_ result: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {
        (user, error) in
        if let error = error {
        print(error.localizedDescription)
        return
        }
            addUser(username: username, email: email)
        Login (email: email, password: password){
        (success: Bool) in
        if(success) {
            print("Login successfull after account creation")
        } else {
            print("Login unsuccessfull after account creation")
        }
        }
        completion("")
        })
        }
    
    static func addUser(username: String, email: String) {
        let uid = Auth.auth().currentUser?.uid
        let post = [
            "uid": uid,
            "username": username,
            "email": email,
            "profileImageUrl": ""
        ]
        databaseRef.child("users").child(uid!).setValue(post)
    }
}
