//
//  UserDefaults.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/19.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

struct UserSstorage {
    static let (nameKey, addressKey) = ("name", "address")
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var name: String?
        var address: String?
        
        init(_ json: [String: String]) {
            self.name = json[nameKey]
            self.address = json[addressKey]
        }
    }
    
    static var saveNameAndAddress = { (name: String, address: String) in
        UserDefaults.standard.set([nameKey: name, addressKey: address], forKey: userSessionKey)
    }
    
    static var getNameAndAddress = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
