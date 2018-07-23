//
//  Order.swift
//  Naber
//
//  Created by melon on 2018/7/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

struct OrderResp : Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [OrderVo]! = []
    
    public static func toJson(structs : OrderResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> OrderResp? {
        do {
            return try JSONDecoder().decode(OrderResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
    
}

struct OrderVo : Codable {

    var  order_uuid: String!
    var  account_uuid: String!
    var  user_message: String!
    var  create_date: String!
    var  update_date: String!
    var  order_price: String!
    var  order_bonus: String!
    var  fetch_date: String!
    var order_data : String!
    var status : String!
    

    
    public static func toJson(structs : OrderVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> OrderVo? {
        do {
            return try JSONDecoder().decode(OrderVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


struct OrderDetail : Codable {
    
    var restaurant_uuid : String!
    var restaurant_name : String! = ""
    var restaurant_address : String!
    var user_name : String!
    var user_phone : String!
    var fetch_date : String!
    var user_message : String!
    var orders : [OrderData]!

    
    public static func toJson(structs : OrderDetail) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> OrderDetail? {
        do {
            return try JSONDecoder().decode(OrderDetail.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


struct OrderData: Codable {
    
    var count: Int! = 0
    var category_uuid: String!
    var item: FoodItemVo!
    
    public static func toJson(structs : OrderData) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    public static func parse(src : String) -> OrderData? {
        do {
            return try JSONDecoder().decode(OrderData.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}



