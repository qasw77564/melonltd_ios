//
//  RegisterStoreViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/23.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

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
        //TODO:ASK SERVER
        if judgmentInput() {
        let account : SellerRegisteredVo = SellerRegisteredVo()
        account.seller_name = self.restaurantName.text
        account.address = self.restaurantAddress.text
        account.name = self.contactPersonName.text
        account.phone = self.contactPhone.text
        account.device_id = ""
        ApiManager.sellerRegistered(structs: account, ui: self, onSuccess:  {
            let alert = UIAlertController(title: "註冊成功", message: "歡迎加入NABER！" , preferredStyle: .alert)
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
//        let alert = UIAlertController(title: "", message: "確定要送出嗎？",   preferredStyle: .alert)
//        let actionTaken = UIAlertAction(title: "確認", style: .default) { (hand) in
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyBoard.instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
//            self.present(destinationVC!, animated: false, completion: nil)
//        }
//        alert.addAction(actionTaken)
//        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
//        self.present(alert, animated: false) {}
        
    }
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

}
