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
    static let SHOPPING_CART: String = "SHOPPING_CART"

    
    // 登入成功記錄登入時間
    static var setLoginTime = { (time: Int) in
        UserDefaults.standard.setValue(time, forKey: LONGIN_TIME)
    }
    
    static func getLoginTime() -> Int {
        if let time = getValue(forKey: LONGIN_TIME) as? Int {
            return time
        } else {
            return 0
        }
    }
    
    // 登入成功記錄登入者資訊
    public static var setAccount = { (account: AccountInfoVo)  in
        UserDefaults.standard.setValue(AccountInfoVo.toJson(structs: account), forKey: ACCOUNT_INFO)
    }
    
    static func getAccount() -> AccountInfoVo? {
        if let account = getValue(forKey: ACCOUNT_INFO) as? String  {
            return AccountInfoVo.parse(src: account)
        }else {
            return nil
        }
    }
    
    // 取得使用者認證
    static func getAutho() -> String {
        if let account = getAccount() {
            return account.account_uuid ?? ""
        }else {
            return ""
        }
    }
    
    // 記住帳號
    public static var setRememberMe = { (isRemember: Bool)  in
        UserDefaults.standard.setValue(isRemember, forKey: REMEMBER_ME)
    }
    
    static func getRememberMe() -> Bool {
        if let remember = getValue(forKey: REMEMBER_ME) as? Bool {
            return remember
        } else {
            return false
        }
    }

    // 使用者夠處車清單
    static func setShoppingCartDatas (datas : [OrderDetail]) {
        let json: String = OrderDetail.toJsonArray(structs: datas)
        UserDefaults.standard.setValue(json, forKey: SHOPPING_CART)
    }
    
    public static func getShoppingCartDatas() -> [OrderDetail] {
        if let remember = getValue(forKey: SHOPPING_CART) as? String {
            print("json : ", remember)
            let datas: [OrderDetail] = OrderDetail.parseArray(src: remember)!
            return datas
        } else {
            return []
        }
    }
    
    private static func getValue(forKey: String)-> Any? {
        printRepresentation()
        if let any : Any = UserDefaults.standard.value(forKey: forKey) {
            return any
        } else {
            return nil
        }
    }
    
    // 清除
    static func clearUserData() {
        let keys: [String] = [LONGIN_TIME, ACCOUNT_INFO, SHOPPING_CART]
        let remember: Bool = getRememberMe()
        keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        setRememberMe(remember)
    }
    // 清除使用者login，account
    static func clearUserLoginTime(){
        let keys: [String] = [LONGIN_TIME, ACCOUNT_INFO]
        let remember: Bool = getRememberMe()
        keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        setRememberMe(remember)
    }
    
    
    static func printRepresentation() {
        let map : [String : Any] = UserDefaults.standard.dictionaryWithValues(forKeys: [LONGIN_TIME, ACCOUNT_INFO, SHOPPING_CART])
        print(map)
    }
   
}
