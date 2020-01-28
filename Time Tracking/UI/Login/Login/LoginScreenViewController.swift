//
//  LoginScreenViewController.swift
//  Time Tracking
//
//  Created by Marlon Morato on 22/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var controller: LoginScreenControllerContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = controller ?? LoginScreenController(viewController: self, securityService: SecurityService())
        
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(touchRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        controller.validateLogin()
    }
    
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        controller.login(email: email, password: password)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        controller.forgotPassword()
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
}
