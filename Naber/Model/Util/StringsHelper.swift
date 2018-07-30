//
//  StringsHelper.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation



class StringsHelper {
    
    // 替代文字
    static func replace (str: String, of: String, with : String) -> String {
        return str.replacingOccurrences(of: of, with: with, options: .literal, range: nil)
    }
    
    // 分割文字產出陣列
    static func splitToArray(str: String, of: String) -> [String] {
        return str.components(separatedBy: of)
    }
    
}
