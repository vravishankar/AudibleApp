//
//  UserDefaults+Helpers.swift
//  AudibleApp
//
//  Created by CnC on 25/12/2017.
//  Copyright © 2017 cnc. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys : String {
        case isLoggedIn
    }
    
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
