//
//  ApiManager.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/18.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager{
   private static let HTTP_HEADERS: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
    
    // 登入
    public static func login (account : AccountInfoVo?, onSuccess : @escaping (AccountInfoVo) -> (), onFail : @escaping (String) -> ()) {
        self.post(url: ApiUrl.LOGIN, data: AccountInfoVo.toJson(account: account!), complete: {
            response in
            let resp: AccountInfoResp = AccountInfoResp.parse(src: base64Decoding(decode: response.result.value!))!
            if resp.status == "true" {
                onSuccess(resp.data)
            }else {
                onFail(resp.err_msg)
            }
        }, uncomplete: {
            err_msg in
            onFail(err_msg)
        })
       
    }
    

    private static func post(url: URLConvertible, data: String , complete : @escaping (DataResponse<String>) -> (), uncomplete : @escaping (String) -> ()) {
        Loading.show()
        let parameter : Parameters =  ["data": base64Encoding(encod: data)]
        Alamofire.request(url, method: HTTPMethod.post, parameters:parameter, headers:HTTP_HEADERS).validate().responseString{
            response in
            if response.result.isSuccess {
                complete(response)
            }else if response.result.isFailure {
                uncomplete("net work error")
            }else if (response.result.error != nil) {
                uncomplete("error")
            }
            Loading.hide()
        }

    }
    
    
    private static func postAutho(url: URLConvertible, data: String , complete : @escaping (DataResponse<String>) -> (), uncomplete : @escaping (String) -> ()) {
        Loading.show()
        let autho : String = "";
        let parameter : Parameters =  ["data": data]
        let header: HTTPHeaders = ["Authorization" : autho, "Content-Type": "application/x-www-form-urlencoded"]

        Alamofire.request(url, method: HTTPMethod.post, parameters:parameter, headers:header).validate().responseString{
            response in
            if response.result.isSuccess {
                complete(response)
            }else if response.result.isFailure {
                uncomplete("net work error")
            }else if (response.result.error != nil) {
                uncomplete("error")
            }
            Loading.hide()
        }
        
    }
    
    // Base64 加密
    private static func base64Encoding(encod: String) -> String {
        
        if NaberConstant.IS_DEBUG {
            return encod
        }
        let plainData = urlEncoded(str: encod).data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    // Base64解密
    private static func base64Decoding(decode: String) -> String {
        if NaberConstant.IS_DEBUG {
            return decode
        }
        let decodedData = Data(base64Encoded: decode, options: Data.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = String(data: decodedData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        return urlDecoded(str: decodedString)
    }
    
    // URL 加密
    private static func urlEncoded(str : String) -> String {
        return str.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
    
    // URL 解密
    private static func urlDecoded(str : String) -> String {
        return str.removingPercentEncoding!
    }
}
