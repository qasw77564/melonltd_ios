//
//  UserDefaults.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/19.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class UserSstorage {
    static let userSessionKey: String = "NAMER"
    static let LONGIN_TIME: String = "LONGIN_TIME"
    static let ACCOUNT_INFO: String = "ACCOUNT_INFO"
    static let REMEMBER_ME: String = "REMEMBER_ME"

    
    // 登入成功記錄登入時間
    static var setLoginTime = { (time: Int) in
        UserDefaults.standard.setValue(time, forKey: LONGIN_TIME)
    }
    
    static func getLoginTime() -> Int {
        if let time = getValue(forKey: LONGIN_TIME) {
            return time as? Int ?? 0
        }
        return 0
    }
    
    // 登入成功記錄登入者資訊
    public static var setAccount = { (account: AccountInfoVo)  in
        UserDefaults.standard.setValue(AccountInfoVo.toJson(structs: account), forKey: ACCOUNT_INFO)
    }
    
    static func getAccount() -> AccountInfoVo? {
        if let account = getValue(forKey: ACCOUNT_INFO) {
            return AccountInfoVo.parse(src: account as! String)
        }
        return nil
//        return AccountInfoVo.parse(src: getValue(forKey: ACCOUNT_INFO) as! String) ?? nil
    }
    
    static func getAutho() -> String {
        if let account = getAccount() {
            return account.account_uuid
        }
        return ""
    }
    
    public static var setRememberMe = { (isRemember: Bool)  in
        UserDefaults.standard.setValue(isRemember, forKey: REMEMBER_ME)
    }
    
    static func getRememberMe() -> Bool {
        if let remember = getValue(forKey: REMEMBER_ME) {
            return remember as? Bool ?? false
        }
        return false
    }

    
    
    
    private static func getValue(forKey: String)-> Any? {
        printRepresentation()
        if let any : Any = UserDefaults.standard.value(forKey: forKey) {
            return any
        }
        return nil
//        let any : Any? = UserDefaults.standard.value(forKey: forKey)
//        print(any)
//
//        return UserDefaults.standard.value(forKey: forKey) as? Any
    }


    // 清除
    static func clearUserData() {
        let keys: [String] = [LONGIN_TIME, ACCOUNT_INFO]
        let remember: Bool = getRememberMe()
        
        keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        setRememberMe(remember)
    }
    
    
    static func printRepresentation() {
        let map : [String : Any] = UserDefaults.standard.dictionaryWithValues(forKeys: [LONGIN_TIME, ACCOUNT_INFO])
//        print(map)
    }
   
}
