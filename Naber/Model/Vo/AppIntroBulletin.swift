//
//  AppIntroBulletin.swift
//  Naber
//
//  Created by 王淳彦 on 2018/9/7.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

class AppIntroBulletinResp: Codable{
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : String!
    
    public static func toJson(structs : AppIntroBulletinResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> AppIntroBulletinResp? {
        do {
            return try JSONDecoder().decode(AppIntroBulletinResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}
