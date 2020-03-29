//
//  LoginViewController.swift
//  Chatting
//
//  Created by Ahmed barghash on 2/25/20.
//  Copyright © 2020 Ahmed barghash. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        
        KRProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                print("Wrong Credintals....!")
                KRProgressHUD.showError(withMessage: "Wrong Credintals....!")
            }else{
                print("Login Succeeded")
                KRProgressHUD.showSuccess()
                self.performSegue(withIdentifier: "goToChat2", sender: self)
            }
        }
        
    }
    

}
