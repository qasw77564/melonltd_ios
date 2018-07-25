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

    
    // 登入成功記錄登入時間
    static var setLoginTime = { (time: Int) in
        UserDefaults.standard.setPersistentDomain([LONGIN_TIME : time], forName: userSessionKey)
    }
    
    static func getLoginTime() -> Int {
        if let domain = getDomain() {
            return (domain as! [String: Int])[LONGIN_TIME]!
        }
        return 0
    }
    
    // 登入成功記錄登入者資訊
    public static var setAccount = { (account: AccountInfoVo)  in
        UserDefaults.standard.setPersistentDomain([ACCOUNT_INFO : AccountInfoVo.toJson(structs: account)], forName: userSessionKey)
    }
    
    static func getAccount() -> AccountInfoVo? {
        if let domain = getDomain() {
            return AccountInfoVo.parse(src: domain[ACCOUNT_INFO] as! String)
        }
        return nil
    }
    
    private static func getDomain() -> [String: Any]? {
        return UserDefaults.standard.persistentDomain(forName: userSessionKey)
    }
    
    // 清除所有持久層資料
    static func clearUserData() {
        UserDefaults.standard.removePersistentDomain(forName: userSessionKey)
    }
    
    
    static func printRepresentation() {
         print(UserDefaults.standard.dictionaryRepresentation())
    }
   
}
