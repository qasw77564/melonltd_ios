//
//  ViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class ViewController: UIViewController {

    @IBOutlet weak var account_text: UITextField!
    
    @IBOutlet weak var password_text: UITextField!
    
    @IBOutlet weak var register_button: UIButton!
    
    @IBOutlet weak var store_register_button: UIButton!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    
    @IBOutlet weak var rememberMeImage: UIButton!
    
    
    
    @IBAction func rememberMeSwithOnImage(_ sender: Any) {
        
        
        
        
        
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func rememberMeSwitch(_ sender: Any) {
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func goToNextPage(_ sender: Any) {
        print("Account Text:" + account_text.text! as Any);
        print("Password Text:" + password_text.text! as Any);
        
//        if self.account_text.text != "" && self.password_text.text != "" {
//            var account: AccountInfoVo = AccountInfoVo()
//            account.phone = self.account_text.text
//            account.password = self.password_text.text
//            account.device_category = "IOS"
//            account.device_token = Messaging.messaging().fcmToken
//            print(account.device_token)
//            ApiManager.login(structs: account, ui: self, onSuccess: { accountInfoVo in
//                print(accountInfoVo)
//                if Identity.USER_TYPE().contains(accountInfoVo.identity) {
//                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
//                        self.present(vc, animated: false, completion: nil)
//                    }
//                }else if Identity.SELLERS == accountInfoVo.identity {
//                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
//                        self.present(vc, animated: false, completion: nil)
//                    }
//                }
//
//            },onFail: { err_msg in
//                print(err_msg)
//                let alert = UIAlertController(title: "系統提示", message: err_msg, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "確認", style: .default))
//                self.present(alert, animated: false)
//
//            })
//        }else {
//            let alert = UIAlertController(title: "系統提示", message: "請確認密碼與帳號", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "確認", style: .default))
//            self.present(alert, animated: false)
//        }
       
        
//
//        account.account_uuid = "USER_20180709_123225_469_bbdd78cc-9786-49eb-8ca5-5ad07446a2ed"
//        ApiManager.logout(structs: account, ui: self, onSuccess: { response in
//            print(response)
//        }) { err_msg in
//            print(err_msg)
//        }
//
//
//        var smsCode: SMSCodeVo = SMSCodeVo()
//        smsCode.phone = "0928297076"
//        ApiManager.getSMSCode(structs: smsCode, ui: self, onSuccess: { smsCodeVo in
//            print(smsCodeVo)
//            smsCode.code = smsCodeVo.code
//            smsCode.batch_id = smsCodeVo.batch_id
//
//            ApiManager.verifySMSCode(structs: smsCode, ui: self, onSuccess: { response in
//                print(response)
//            }, onFail: {  err_msg in
//                print(err_msg)
//            })
//        }) {  err_msg in
//            print(err_msg)
//            let alert = UIAlertController(title: "系統提示", message: err_msg, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "確認", style: .default))
//            self.present(alert, animated: false)
//        }
        
        
//        account.name = "Evan Wang"
//        account.phone = "1982749521"
//        account.identity = "NON_STUDENT"
//        account.password = "s123456"
//
//        ApiManager.userRegistered(structs: account, ui: self, onSuccess: {
//            let alert = UIAlertController(title: "系統提示", message: "完成註冊，\n歡迎加入NABER！", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "返回登入畫面", style: .default))
//            self.present(alert, animated: false)
//
//        }) { err_msg in
//             print(err_msg)
//            let alert = UIAlertController(title: "系統提示", message: err_msg, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "確認", style: .default))
//            self.present(alert, animated: false)
//        }
        
//        var sellerRegistered: SellerRegisteredVo = SellerRegisteredVo()
//        sellerRegistered.seller_name = "seller_name"
//        sellerRegistered.phone = "0987654322"
//        sellerRegistered.address = "ADDRE"
//        sellerRegistered.device_id = Messaging.messaging().fcmToken
//        sellerRegistered.name = "WWWWW"
//        
//        ApiManager.sellerRegistered(structs: sellerRegistered, ui: self, onSuccess: {
//            
//        }) { err_msg in
//            print(err_msg)
//        }
        
        
//
//        ApiManager.advertisement(ui: self, onSuccess: { advertisements in
//            for item in advertisements {
//                print(item?.content_text ?? "")
//                print(item?.photo ?? "")
//            }
//        }) {err_msg in
//            print(err_msg)
//        }

        // 偏好儲存
//        let map:[String: String] = UserDefaults.standard.value(forKey: "NAME") as! [String : String]
//        print(map["name"] as! String )
//        UserDefaults.standard.set(["name":"evan"],forKey:"NAME")
//        let model = Defaults.getNameAndAddress
//        print(model.address ?? "")
        
//        Defaults.saveNameAndAddress("Anand", "Bengalore")
//        Defaults.clearUserData()
        
//        ApiManager.bulletin(ui: self, onSuccess: { bulletins in
//            var map: [String: String] = [:]
//            for item in bulletins {
////                if item?.bulletin_category == "HOME" {
//                    // 切割 String to Array
//////                    let content_texts:[String] =  (item?.content_text.components(separatedBy: "$split"))!
////                    map.updateValue((item?.content_text.replacingOccurrences(of: "$split", with: "\n"))!, forKey: (item?.bulletin_category)!)
////                } else {
////
////                }
//                // 切割 String 替代文字
//                map.updateValue((item?.content_text.replacingOccurrences(of: "$split", with: "\n"))!, forKey: (item?.bulletin_category)!)
//            }
//
//            for m in map {
//                print(m.value)
//            }
//
//        }) { (err_msg) in
//            print(err_msg)
//        }
        
       
        switch account_text.text {
        case "1":
            // Safe Present
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController
            {
                present(vc, animated: false, completion: nil)
            }
        case "2":
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController
            {
                present(vc, animated: false, completion: nil)
            }
        case "3":
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tutorial") as? TutorialVC
            {
                present(vc, animated: false, completion: nil)
            }
        default:
            print("Stop running")
        }
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print("device token : " + deviceID)
        
//        register_button.layer.borderWidth = 1
//        register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
//        
//        store_register_button.layer.borderWidth = 1
//        store_register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//}

