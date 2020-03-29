//
//  RegisterViewController.swift
//  Chatting
//
//  Created by Ahmed barghash on 2/25/20.
//  Copyright © 2020 Ahmed barghash. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        
        KRProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print("Invalid Email...!")
                KRProgressHUD.showError(withMessage: "Invalid Email...!")
                print(error!)
            }else{
               print("Register Succeeded")
                KRProgressHUD.showSuccess()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    }
    
}
