//
//  Food.swift
//  Naber
//
//  Created by melon on 2018/7/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation

struct FoodListResp : Codable {
    var status : String!
    var err_code : String!
    var err_msg : String!
    var data : [FoodVo?]!

    public static func toJson(structs : FoodListResp) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }

    public static func parse(src : String) -> FoodListResp? {
        do {
            return try JSONDecoder().decode(FoodListResp.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }

}

struct FoodVo : Codable {
    var food_uuid : String!
    var category_uuid : String!
    var food_name : String!
    var default_price : String!
    var photo : String!
    var photo_type : String!
    var food_data : FoodItemVo!
    var status : String!


    public static func toJson(structs : FoodVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }

    public static func parse(src : String) -> FoodVo? {
        do {
            return try JSONDecoder().decode(FoodVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}


struct FoodItemVo: Codable {
    var food_uuid: String!
    var category_name: String!
    var food_name: String!
    var price: String!
    var food_photo: String!

    var scopes: [ItemVo]! = []
    var opts: [ItemVo]! = []
    var demands: [DemandsItemVo]! = []


    public static func toJson(structs: FoodItemVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }

    public static func parse(src : String) -> FoodItemVo? {
        do {
            return try JSONDecoder().decode(FoodItemVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }

}


struct ItemVo : Codable {
    var name : String!
    var price : String!

    public static func toJson(structs : ItemVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }

    public static func parse(src : String) -> ItemVo? {
        do {
            return try JSONDecoder().decode(ItemVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}



struct DemandsItemVo : Codable {
    var name : String!
    var datas : [ItemVo?]! = []

    public static func toJson(structs : DemandsItemVo) -> String {
        do {
            return String(data: try JSONEncoder().encode(structs), encoding: .utf8)!
        } catch {
            return ""
        }
    }

    public static func parse(src : String) -> DemandsItemVo? {
        do {
            return try JSONDecoder().decode(DemandsItemVo.self, from: src.data(using:.utf8)!)
        }catch {
            return nil
        }
    }
}








