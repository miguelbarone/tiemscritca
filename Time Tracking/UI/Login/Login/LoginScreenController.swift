//
//  LoginScreenController.swift
//  Time Tracking
//
//  Created by Marlon Morato on 28/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation
import UIKit

protocol LoginScreenControllerContract {
    func validateLogin()
    func login(email: String, password: String)
    func forgotPassword()
}

class LoginScreenController: LoginScreenControllerContract {
    private var securityService: SecurityServiceContract
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController, securityService: SecurityServiceContract) {
        self.viewController = viewController
        self.securityService = securityService
    }
    
    func validateLogin() {
        guard securityService.currentUser != nil else { return }
        
        goToHomeScreen()
    }
    
    func login(email: String, password: String) {
        securityService.login(email: email, password: password)
        goToHomeScreen()
    }
    
    func forgotPassword() {
        guard let vc = self.viewController else { return }
        
        let viewController = ForgotPasswordViewController()
        viewController.presenter = ForgotPasswordPresenter(delegate: viewController)
        vc.show(viewController, sender: self)
    }
    
    private func goToHomeScreen() {
        guard let vc = self.viewController else { return }
        
        let viewController = HomeScreenViewController(nibName: "HomeScreenViewController", bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        
        vc.present(viewController, animated: true, completion: nil)
    }
}


