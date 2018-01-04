//
//  ViewController.swift
//  swiftChat
//
//  Created by Dhwty on 30/11/2017.
//  Copyright © 2017 Dhwty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginClicked(_ sender: Any) {
//        let email = "test1@gmail.com"
//        let password = "openopen"
        FirebaseManager.Login(email: email.text!, password: password.text!, completion: {(success:Bool) in
            if(success) {
               self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        })
    }
    
    
    @IBAction func createAccountButton_clicked(_ sender: Any) {
        FirebaseManager.CreateAccount(email: email.text!, password: password.text!, username: username.text!) { (result: String) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showProfile", sender: sender)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

