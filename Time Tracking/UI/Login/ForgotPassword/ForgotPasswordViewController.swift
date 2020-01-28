//
//  recoveryUserViewController.swift
//  Time Tracking
//
//  Created by Gabriel dos Santos Nascimento - GNS on 14/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    private let DEFAULT_MARGIN: CGFloat = 20.0
    private let DEFAULT_SPACING: CGFloat = 40.0
    private let SMALL_SPACING: CGFloat = 20.0
    
    private lazy var recoverEmailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "seu email aqui..."
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        
        return textField
    }()
    
    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite seu email de cadastro no campo abaixo, e toque em enviar, para receber as instruções de recuperação de senha."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "marineBlue")
        
        return label
    }()
    
    private lazy var sendEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
        button.tintColor = UIColor(named: "pumpkinOrange")
        
        button.addTarget(self, action: #selector(sendRecoverEmail), for: .touchUpInside)
        
        return button
    }()
    
    var presenter: ForgotPasswordPresenterContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = presenter ?? ForgotPasswordPresenter(delegate: self)
        
        self.view.backgroundColor = .white
        
        setGestures()
        setRecoverEmailTextField()
        setInstructionsLabel()
        setSendEmailButton()
    }
    
    private func setSendEmailButton() {
        self.view.addSubview(self.sendEmailButton)
        NSLayoutConstraint.activate([
            self.sendEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.sendEmailButton.topAnchor.constraint(equalTo: self.recoverEmailTextField.bottomAnchor, constant: SMALL_SPACING),
        ])
    }
    
    private func setInstructionsLabel() {
        self.view.addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            self.instructionsLabel.leadingAnchor.constraint(equalTo: recoverEmailTextField.leadingAnchor),
            self.instructionsLabel.trailingAnchor.constraint(equalTo: recoverEmailTextField.trailingAnchor),
            self.instructionsLabel.bottomAnchor.constraint(equalTo: self.recoverEmailTextField.topAnchor, constant: -DEFAULT_SPACING),
        ])
    }
    
    private func setRecoverEmailTextField() {
        self.view.addSubview(recoverEmailTextField)
        NSLayoutConstraint.activate([
            self.recoverEmailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DEFAULT_MARGIN),
            self.recoverEmailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DEFAULT_MARGIN),
            self.recoverEmailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.recoverEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    @objc private func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    private func dissmissModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendRecoverEmail(){
        guard let email = recoverEmailTextField.text, !email.isEmpty else { return }
        self.presenter.sendRecoverEmail(email)
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    func finish() {
        self.dissmissModal()
    }
    
    func alert(error: String) {
        print(error)
    }
}

