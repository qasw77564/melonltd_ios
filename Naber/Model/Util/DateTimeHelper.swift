//
//  DateTimeHelper.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation


class DateTimeHelper {  
    static var formatter: DateFormatter = getFormatter()

    static func getFormatter() -> DateFormatter {
        let form: DateFormatter = DateFormatter()
        form.timeZone = TimeZone.init(identifier: "UTC")
        form.locale = Locale.init(identifier: "zh_TW")
        form.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        return form
    }
    
    static func getNowMilliseconds() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
    static func getNow() -> String  {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        return  formatter.string(from: Date())
    }
    
    static func stringToDate(data: String) -> Date {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        let date = formatter.date(from: data)
        return date!
    }
    
    static func dateToString(date: Date) -> String {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        let date = formatter.string(from: date)
        return date
    }
    
    static func dateToStringForm(date: Date, form: String) -> String {
        formatter.dateFormat = form
        let date = formatter.string(from: date)
        return date
    }
    
    static func formToString(date: String, from: String) -> String {
        let d: Date = stringToDate(data: date)
        return dateToStringForm(date: d, form: from)
    }
    
    static func startOfDate() -> String {
        let now = Calendar.init(identifier: .chinese).startOfDay(for: Date())
        return dateToString(date: now)
    }
    
    
}
