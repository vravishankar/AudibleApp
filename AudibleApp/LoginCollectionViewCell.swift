//
//  LoginCollectionViewCell.swift
//  AudibleApp
//
//  Created by CnC on 24/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
    //MARK: Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: LoginViewControllerDelegate?
    
    //MARK: Components
    
    let logoView : UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailTextField : LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.placeholder = "Enter Email"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField : LeftPaddedTextField = {
        let tf = LeftPaddedTextField()
        tf.placeholder = "Enter Password"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Login", for: .normal)
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    //MARK: Private Methods
    
    @objc private func handleLogin() {
        delegate?.finishLoggingIn()
    }
    
    private func setupViews() {
        
        addSubview(logoView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        logoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 32).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}

class LeftPaddedTextField : UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
