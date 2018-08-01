//
//  RegisterUserDetailViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/22.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
//    var toolbar: UIToolbar!
//    var accessoryToolbar: UIToolbar {
//        get {
//            let toolbarFrame = CGRect(x: 0, y: 0,
//                                      width: view.frame.width, height: 44)
//            let accessoryToolbar = UIToolbar(frame: toolbarFrame)
//            let doneButton = UIBarButtonItem(title: "完成" , style: .done, target: self,action: #selector(onDoneButtonTapped(sender:)))
//            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target: nil, action: nil)
//
//            let cancelButton = UIBarButtonItem(title:"取消" , style: .plain,target: self, action: #selector(onCancelButtonTapped(sender:)))
//            let titleBarButton = UIBarButtonItem(title: "請選擇" , style: .done, target: nil, action: nil)
//            titleBarButton.isEnabled = false
//
//            accessoryToolbar.items = [cancelButton, flexibleSpace,titleBarButton, flexibleSpace, doneButton]
//            accessoryToolbar.barTintColor = UIColor.white
//            return accessoryToolbar
//        }
//    }


class RegisterUserDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var phone: String! = Optional.none
    var identity: String = ""
    var schoolName: String = ""
    var identityPickerView: UIPickerView {
        get {
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.backgroundColor = UIColor.white
            return pickerView
        }
    }
    
    //    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var identityText : UITextField! {
        didSet {
            identityText.inputView = self.identityPickerView
        }
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordCheck: UITextField!
    @IBOutlet weak var name : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.identity = Array(NaberConstant.IDENTITY_OPTS_TEMP)[0].key
        self.schoolName = NaberConstant.IDENTITY_OPTS_TEMP[identity]![0]
        self.identityText.text =  self.identity + ", " + self.schoolName
    }
    
    @IBAction func goBackHomePage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
        {
            present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func sendToSeverForRegisterUser(_ sender: Any) {
        if verifyInput() {
            let account: AccountInfoVo = AccountInfoVo()
            account.name = self.name.text
            account.password = self.password.text
            
            if NaberConstant.IS_DEBUG{
                account.phone = "0987878787"
            } else {
                account.phone = self.phone
            }
            account.level = "USER"
            account.identity = Identity.toEnum(name: self.identity).rawValue
            account.school_name = self.schoolName
            
            ApiManager.userRegistered(structs: account, ui: self, onSuccess: {
                let alert = UIAlertController(title: "", message: "完成註冊，\n歡迎加入NABER！" , preferredStyle: .alert)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyInput() -> Bool {
        var msg: String = ""
        
        if self.passwordCheck.text != self.password.text{
            msg = "請確定密碼與確認密碼一致"
        }
        
        if !ValidateHelper.validatePass(withPassword: self.password.text!){
            msg = "密碼長度需6~20碼，\n並英數組合！"
        }
        
        if self.password.text == "" {
            msg = "密碼不可為空"
        }
        
        if (self.name.text?.count)! < 2 || (self.name.text?.count)! > 5 {
            msg = "姓名格式不正確長度為2~5"
        }
        
        if self.name.text == "" {
            msg = "姓名不可為空"
        }
        
        if msg != "" {
            let alert = UIAlertController(title: "", message: msg,   preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "關閉", style: .cancel, handler: { _ in
                self.passwordCheck.text = ""
            }
            ))
            self.present(alert, animated: false)
        }
        return msg == ""
    }
    
    //身份選擇
    // MARK: - UIPickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 身份類型
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return NaberConstant.IDENTITY_OPTS_TEMP.count
        } else {
            let array: [String] = Array(NaberConstant.IDENTITY_OPTS_TEMP)[pickerView.selectedRow(inComponent: 0)].value
            return array.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            pickerView.reloadComponent(1)
            return Array(NaberConstant.IDENTITY_OPTS_TEMP)[row].key
        } else {
            let array: [String] =  Array(NaberConstant.IDENTITY_OPTS_TEMP)[pickerView.selectedRow(inComponent: 0)].value
            if row > array.count {
                return ""
            } else {
                return array[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //滑動左邊pick的時候
        if component == 0 {
            self.identity = Array(NaberConstant.IDENTITY_OPTS_TEMP)[row].key
            self.schoolName = NaberConstant.IDENTITY_OPTS_TEMP[self.identity]![0]
            pickerView.reloadComponent(1)
        } else {
            let array: [String] =  Array(NaberConstant.IDENTITY_OPTS_TEMP)[pickerView.selectedRow(inComponent: 0)].value
            if row < array.count {
                self.schoolName = array[row]
            }
        }
        self.identityText.text =  self.identity + ", " + self.schoolName
    }
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


