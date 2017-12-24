//
//  MainNavigationControllerViewController.swift
//  AudibleApp
//
//  Created by CnC on 24/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        if isLoggedIn() {
            // user logged in
            let homeController = HomeController()
            viewControllers = [homeController]
            
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.1)
        }

    }
    
    @objc func showLoginController() {
        let controller = LoginViewController()
        present(controller, animated: true, completion: {
            // later
        })
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn
    }

}


