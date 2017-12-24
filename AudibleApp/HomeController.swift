//
//  HomeController.swift
//  AudibleApp
//
//  Created by CnC on 25/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "Welcome"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        let lblDisplay = UILabel()
        lblDisplay.text = "Welcome to App"
        lblDisplay.font = UIFont.boldSystemFont(ofSize: 24)
        lblDisplay.textAlignment = .center
        lblDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblDisplay)
        
        lblDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblDisplay.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lblDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        lblDisplay.heightAnchor.constraint(equalToConstant: 20)
        
    }
    
    @objc func handleSignOut() {
        UserDefaults.standard.setLoggedIn(value: false)
        
        let controller = LoginViewController()
        present(controller, animated: true, completion: nil)
    }
}
