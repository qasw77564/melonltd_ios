//
//  ApiManager.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/18.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
   private static let HTTP_HEADERS: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
    
    // 登入
    public static func login (account: AccountInfoVo?, ui: UIViewController, onSuccess: @escaping (AccountInfoVo) -> (), onFail: @escaping (String) -> ()) {
        self.postData(url: ApiUrl.LOGIN, data: AccountInfoVo.toJson(account: account!),ui:ui, complete: { response in
            let resp: AccountInfoResp = AccountInfoResp.parse(src: base64Decoding(decode: response.result.value!))!
            if resp.status == "true" {
                onSuccess(resp.data)
            }else {
                onFail(resp.err_msg)
            }
        })
    }
    
    private static func postData(url: URLConvertible, data: String , ui: UIViewController, complete: @escaping (DataResponse<String>) -> ()) {
        let parameter: Parameters =  ["data": base64Encoding(encod: data)]
        self.post(url: url, parameter: parameter, header: self.HTTP_HEADERS, ui: ui) { response in
            complete(response)
        }
    }
    
    private static func postAutho(url: URLConvertible, data: String, ui: UIViewController, complete: @escaping (DataResponse<String>) -> ()) {
        let autho : String = "";
        let parameter : Parameters =  ["data": data]
        let header: HTTPHeaders = ["Authorization" : autho, "Content-Type": "application/x-www-form-urlencoded"]

        self.post(url: url, parameter: parameter, header: header, ui: ui) { response in
            complete(response)
        }
    }
    
    private static func post(url: URLConvertible, parameter: Parameters, header: HTTPHeaders, ui: UIViewController, complete: @escaping (DataResponse<String>) -> ()) {
        Loading.show()
        Alamofire.request(url, method: HTTPMethod.post, parameters:parameter, headers:header).validate().responseString{ response in
            if response.result.isSuccess {
                complete(response)
            }else if (response.result.error != nil) {
                let alert = UIAlertController(title: "系統提示", message: "請確認裝置有連結網路！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確認", style: .default))
                ui.present(alert, animated: false)
            }else if response.result.isFailure {
                let alert = UIAlertController(title: "系統提示", message: "資料請求失敗，\n可能現在網路處於不穩定狀態，\n請稍後再試！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確認", style: .default))
                ui.present(alert, animated: false)
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
    
//
//    func networkStatusChanged(_ notification: Notification) {
//        let userInfo = (notification as NSNotification).userInfo
//        print(userInfo!)
//    }
    
//    
//    private static func checkNetWork() -> Bool {
//        var checkResult : Bool = true
//        NetworkReachabilityManager()?.listener = { status in
//            switch status {
//            case .notReachable:
//                print("The network is not reachable")
//                checkResult = false
////                self.onInternetDisconnection()
//            case .unknown :
//                print("It is unknown whether the network is reachable")
//            checkResult = false
////                self.onInternetDisconnection() // not sure what to do for this case
//            case .reachable(.ethernetOrWiFi):
//                print("The network is reachable over the WiFi connection")
////                self.onInternetConnection()
//            case .reachable(.wwan):
//                print("The network is reachable over the WWAN connection")
////                self.onInternetConnection()
//            }
//        }
//        return checkResult
//    }
}
