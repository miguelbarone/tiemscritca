//
//  ForgotPasswordPresenter.swift
//  Time Tracking
//
//  Created by Marlon Morato on 28/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation

protocol ForgotPasswordPresenterContract {
    func sendRecoverEmail(_ email: String)
}

protocol ForgotPasswordViewDelegate: class {
    func finish()
    func alert(error: String)
}

class ForgotPasswordPresenter: ForgotPasswordPresenterContract {
    private weak var delegate: ForgotPasswordViewDelegate?
    
    init(delegate: ForgotPasswordViewDelegate) {
        self.delegate = delegate
    }
    
    func sendRecoverEmail(_ email: String) {
        if email.contains("@") {
            self.delegate?.finish()
        } else {
            self.delegate?.alert(error: "Email inválido")
        }
    }
}
