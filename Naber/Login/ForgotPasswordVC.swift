//
//  ForgotPasswordViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/22.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendToServerForAskPassword(_ sender: Any) {
        
        if judgmentInput(){
//            let reqDate : ReqData = ReqData()
//            reqDate.phone = self.phone.text
//            ApiManager.forgetPassword( req: reqDate, ui: self, onSuccess: {
//                let alert = UIAlertController(title: "", message: "感謝你註冊成為商家你，\n您的信息已經提交成功，\n請待客服與您聯繫!!" , preferredStyle: .alert)
//                alert.addAction(UIAlertAction.init(title: "返回登入畫面", style: .default, handler: { _ in
//                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
//                        self.present(vc, animated: false, completion: nil)
//                    }
//                }, onFail: { (err_msg) in
//
//                }
//            }
        }
    }
//    找回密碼判斷
            func judgmentInput() -> Bool {
                var msg: String = ""
                if(ValidateHelper.shared.isVaildTelPhone(withCellPhone: self.phone.text!) ){
                    msg = "請輸入正確的手機號碼"
                }
                if self.phone.text == "" {
                    msg = "手機號碼不可為空"
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
