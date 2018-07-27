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

class LoginVC: UIViewController {
    
    
    let USER_TYPES: [Identity] = Identity.getUserValues()

    @IBOutlet weak var account_text: CustomSearchTextField! 
    @IBOutlet weak var password_text: CustomSearchTextField!
    @IBOutlet weak var register_button: UIButton!
    @IBOutlet weak var store_register_button: UIButton!
//    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var rememberMeImage: UIButton!
 
    @IBOutlet weak var table: UITableView!

    @IBAction func rememberMeSwithOnImage(_ sender: Any) {
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print("device token : " + deviceID)
        
        if UserSstorage.getRememberMe() {
            self.rememberMeImage.setImage(UIImage(named:"cbSelect"), for: .normal)
            self.account_text.text = UserSstorage.getAccount()?.account
        } else {
            self.rememberMeImage.setImage(UIImage(named: "cbNoSelect"), for: .normal)
            self.account_text.text = "0928297076"
        }
        
        if NaberConstant.IS_DEBUG {
            self.account_text.text = "0928297076"
            self.password_text.text = "s123456"
        }
        
        
//        let remember: Bool = UserSstorage.getRememberMe()
//        let image = UIImage(named: remember ? "cbSelect" : "cbNoSelect" ) as UIImage?
        
//        self.rememberMeImage.setValue(true, forKey: "remember")
        //        register_button.layer.borderWidth = 1
        //        register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
        //
        //        store_register_button.layer.borderWidth = 1
        //        store_register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
        
    }
    
    
    
    private func verifyInput () -> String {
        var msg: String = ""
        if self.account_text.text == "" {
            msg = "請輸入帳號"
        }
        if self.password_text.text == "" {
            msg = "請輸入密碼"
        }
        if msg != "" {
            let alert = UIAlertController(title: "系統提示", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .default))
            self.present(alert, animated: false)
        }
        return msg
    }

    
    @IBAction func goToNextPage(_ sender: Any) {

        if self.verifyInput() == "" {
            let reqData: AccountInfoVo = AccountInfoVo()
            reqData.phone = self.account_text.text
            reqData.password = self.password_text.text
            reqData.device_category = "IOS"
            reqData.device_token = Messaging.messaging().fcmToken
            ApiManager.login(structs: reqData, ui: self, onSuccess: { account in
                if account != nil {
                    let now: Int = DateTimeHelper.getNowMilliseconds()
                    UserSstorage.setLoginTime(now)
                    UserSstorage.setAccount(account!)
                    let remember: Bool = (self.rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))!
                    UserSstorage.setRememberMe(remember)
                    print(remember)
                    
                    UserSstorage.printRepresentation()
                    if self.USER_TYPES.contains(Identity.init(rawValue: (account?.identity.uppercased())!)!) {
                        // 使用者
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
                            self.present(vc, animated: false, completion: nil)
                        }
                    } else if Identity.SELLERS == Identity.init(rawValue: (account?.identity.uppercased())!)! {
                        // 商家端
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
                            self.present(vc, animated: false, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "系統提示", message: "查無此帳號！", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "取消", style: .default))
                        self.present(alert, animated: false)
                    }
                }else {
                    let alert = UIAlertController(title: "系統提示", message: "查無此帳號！", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "取消", style: .default))
                    self.present(alert, animated: false)
                }
            }) { err_msg in
                let alert = UIAlertController(title: "系統提示", message: err_msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "取消", style: .default))
                self.present(alert, animated: false)
            }
        }
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

