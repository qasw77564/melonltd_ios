//
//  Identity.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//
//     JUNIOR("小學生"),
//     INTERMEDIATE("國中生"),
//     SENIOR("高中生"),
//     UNIVERSITY("大學/大專院校生"),
//     NON_STUDENT("社會人士/其它"),
//     SELLERS("SELLERS")
import Foundation


class Identity {
   static let
    JUNIOR: String = "JUNIOR" ,
    INTERMEDIATE: String = "INTERMEDIATE",
    SENIOR: String = "SENIOR",
    UNIVERSITY: String = "UNIVERSITY",
    NON_STUDENT: String = "NON_STUDENT",
    SELLERS: String = "SELLERS"
    
    public static func USER_TYPE() -> [String] {
        return [JUNIOR, INTERMEDIATE, SENIOR, UNIVERSITY, NON_STUDENT]
    }
}
