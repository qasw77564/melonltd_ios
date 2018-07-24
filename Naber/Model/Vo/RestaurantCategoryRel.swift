//
//  RestaurantCategoryRel.swift
//  Naber
//
//  Created by melon on 2018/7/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class RestaurantCategoryRelResp : Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [RestaurantCategoryRelVo]! = []
    
    public static func toJson(structs : RestaurantCategoryRelResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantCategoryRelResp? {
        do {
            return try JSONDecoder().decode(RestaurantCategoryRelResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
}


class RestaurantCategoryRelVo : Codable {
    
    var category_uuid: String!
    var restaurant_uuid: String!
    var category_name: String!
    var status : String!
    
    public static func toJson(structs : RestaurantCategoryRelVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> RestaurantCategoryRelVo? {
        do {
            return try JSONDecoder().decode(RestaurantCategoryRelVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}
