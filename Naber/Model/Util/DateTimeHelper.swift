//
//  DateTimeHelper.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class DateTimeHelper {
    
    static var formatter: DateFormatter = DateFormatter()
    
    
    
    static func getNowMilliseconds() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
    static func getNow() -> String  {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        return  formatter.string(from: Date())
    }
    
    static func getNow2 () -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        return  formatter.string(from: Date())
    }
    
//    var getNowMilliseconds = { _ -> Int in
//
//    }(())
//
//    var getNow = { _ -> String in
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
//        return  formatter.string(from: Date())
//    }(())
    
//    var getNow2 = { _ -> String in
//        formatter.dateFormat = "yyyy-MM-dd"
//        return  formatter.string(from: Date())
//    }(())
    
}
