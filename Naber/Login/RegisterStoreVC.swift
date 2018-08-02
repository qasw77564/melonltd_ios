//
//  RegisterStoreViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/23.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class RegisterStoreVC: UIViewController {
    @IBOutlet weak var restaurantName: UITextField!
    @IBOutlet weak var restaurantAddress: UITextField!
    @IBOutlet weak var contactPersonName: UITextField!
    @IBOutlet weak var contactPhone: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sendToSeverForRegisterStore(_ sender: Any) {
        if judgmentInput() {
        let account : SellerRegisteredVo = SellerRegisteredVo()
        account.seller_name = self.restaurantName.text
        account.address = self.restaurantAddress.text
        account.name = self.contactPersonName.text
        account.phone = self.contactPhone.text
        account.device_id = Messaging.messaging().fcmToken
        ApiManager.sellerRegistered(structs: account, ui: self, onSuccess:  {
            let alert = UIAlertController(title: "", message: "感謝你註冊成為商家你，\n您的信息已經提交成功，\n請待客服與您聯繫!!" , preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "返回登入畫面", style: .default, handler: { _ in
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                    self.present(vc, animated: false, completion: nil)
                }
            }))
            self.present(alert, animated: false)
        }) { err_msg in
            let alert = UIAlertController(title: "", message: err_msg , preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: { _ in
                
            }))
            self.present(alert, animated: false)
            }
        }
    }
    //商家註冊判斷
    func judgmentInput() -> Bool {
        var msg: String = ""
        if  !ValidateHelper.shared.isVaildTelPhone(withCellPhone: self.contactPhone.text!){
            msg = "請輸入正確的手機號碼"
        }
        if(self.contactPhone.text == ""){
            msg = "請輸入手機號碼，以便客服與您聯繫!"
        }
        if(self.contactPersonName.text == ""){
            msg = "請輸入聯絡人姓名"
        }
        if(self.restaurantAddress.text == ""){
            msg = "請輸入地址"
        }
        if(self.restaurantName.text == ""){
            msg = "請輸入商店名稱"
        }
        if msg != "" {
            let alert = UIAlertController(title: "", message: msg,   preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "關閉", style: .cancel, handler: { _ in
            }))
            self.present(alert, animated: false)
        }
        return msg == ""
    }
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
