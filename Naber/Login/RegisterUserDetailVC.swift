//
//  RegisterUserDetailViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/22.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

extension Date {
    var mediumDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = NSLocale(
            localeIdentifier: "zh_TW") as Locale
        
        return formatter.string(from: self)
    }
}

class RegisterUserDetailVC: UIViewController {
    var phone: String! = Optional.none
    var key: String = ""
    var value: String = ""
    
    
    var datePicker: UIDatePicker {
        get {
            let datePicker = UIDatePicker()
            // 設置 UIDatePicker 格式
            datePicker.datePickerMode = .date
            
            
            
            
            // 設置 NSDate 的格式
            let formatter = DateFormatter()
            
            // 設置時間顯示的格式
            formatter.dateFormat = "yyyy-MM-dd"
            
            // 設置顯示的語言環境
            datePicker.locale = NSLocale(
                localeIdentifier: "zh_TW") as Locale
            
            
            datePicker.addTarget(self,
                                 action: #selector(onDateChanged(sender:)),
                                 for: .valueChanged)
            datePicker.backgroundColor = UIColor.white

            
            
            
            
            return datePicker
        }
    }
    
//    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var pickerViewTextField : UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCKField: UITextField!
    @IBOutlet weak var register_name : UITextField!
    private var customerIdentifyDataPicker: UIPickerView!{
        didSet {
        
        }
    }
    
//    var oldIdentityText : String?
    var oldBirthDateText : String?
    var pickerView: UIPickerView {
        get {
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.backgroundColor = UIColor.white
            return pickerView
        }
    }
    
    var accessoryToolbar: UIToolbar {
        get {
            let toolbarFrame = CGRect(x: 0, y: 0,
                                      width: view.frame.width, height: 44)
            let accessoryToolbar = UIToolbar(frame: toolbarFrame)
            let doneButton = UIBarButtonItem(title: "完成" , style: .done,
                                             target: self,
                                             action: #selector(onDoneButtonTapped(sender:)))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil                                                )
            let cancelButton = UIBarButtonItem(title:"取消" , style: .plain,
                                               target: self,
                                               action: #selector(onCancelButtonTapped(sender:)))
            let titleBarButton = UIBarButtonItem(title: "請選擇" , style: .done, target: nil, action: nil)
            titleBarButton.isEnabled = false
            
            accessoryToolbar.items = [cancelButton, flexibleSpace,titleBarButton, flexibleSpace, doneButton]
            accessoryToolbar.barTintColor = UIColor.white
            return accessoryToolbar
        }
    }

    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.key = Array(NaberConstant.IDENTITY_OPTS_TEMP)[0].key
        self.value = NaberConstant.IDENTITY_OPTS_TEMP[key]![0]
        self.pickerViewTextField.text =  self.key + ", " + self.value
        
        setupUI()
    }
    func setupUI(){
//        datePickerTextField.inputView = datePicker
//        datePickerTextField.inputAccessoryView = accessoryToolbar
        // Giving the date picker text field an initial value.
        
        
        
        pickerViewTextField.inputView = pickerView
        pickerViewTextField.inputAccessoryView = accessoryToolbar
        
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
//        datePickerTextField.text = sender.date.mediumDateString
    }
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
//        if datePickerTextField.isFirstResponder {
//            oldBirthDateText = datePickerTextField.text
//            datePickerTextField.resignFirstResponder()
//        }
        
//        if pickerViewTextField.isFirstResponder {
//            oldIdentityText = pickerViewTextField.text
//            pickerViewTextField.resignFirstResponder()
//        }
    }
    
    @objc func onCancelButtonTapped(sender: UIBarButtonItem) {
//        if datePickerTextField.isFirstResponder {
//            datePickerTextField.resignFirstResponder()
//            datePickerTextField.text = oldBirthDateText
//        }
        
//        if pickerViewTextField.isFirstResponder {
//            pickerViewTextField.text = oldIdentityText
//            pickerViewTextField.resignFirstResponder()
//        }
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBAction func goBackHomePage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
        {
            present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func sendToSeverForRegisterUser(_ sender: Any) {
        //TODO:ASK SERVER
   
        if verifyInput() {

            let account: AccountInfoVo = AccountInfoVo()
            account.name = self.register_name.text
            account.password = self.passwordField.text
            
            if NaberConstant.IS_DEBUG{
                account.phone = "091234567"
            } else {
                account.phone = self.phone
            }
            account.level = "USER"
            account.identity = Identity.toEnum(name: self.key).rawValue
            account.school_name = self.value
            
            ApiManager.userRegistered(structs: account, ui: self, onSuccess: {
                print("OK")
                let alert = UIAlertController(title: "", message: "完成註冊，\n歡迎加入NABER！" , preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "返回登入畫面", style: .default, handler: { _ in
                    // to login page
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                        self.present(vc, animated: false, completion: nil)
                    }
                }))
                self.present(alert, animated: false)
                
                
            }) { err_msg in
                let alert = UIAlertController(title: "", message: err_msg , preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: { _ in
                    print("error")
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

        if self.pickerViewTextField.text == "" {
            msg = "驗證身份不可為空"
        }
        //name no nil
        if self.register_name.text == "" {
            msg = "姓名不可為空"
        }
        //name == 2~5 count
        if !ValidateHelper.validateName(withChinese: self.register_name.text!) {
            msg = "姓名格式不正確長度為2~5"
        }
        //password
        if !ValidateHelper.validatePass(withPass: self.passwordField.text!){
            msg = "密碼介於6~20個之間"
        }

        //password check
        if self.passwordCKField.text == self.passwordField.text{
            msg = "請確定密碼與確認密碼一致"
        }



        if msg != "" {
            msg = "請輸入資料"
            let alert = UIAlertController(title: "", message: msg,   preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "關閉", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        }


        return msg == ""
    }

}


//身份選擇
// MARK: - UIPickerView Methods
extension RegisterUserDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
       //
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
            self.key = Array(NaberConstant.IDENTITY_OPTS_TEMP)[row].key
            self.value = NaberConstant.IDENTITY_OPTS_TEMP[self.key]![0]
            pickerView.reloadComponent(1)
        } else {
            let array: [String] =  Array(NaberConstant.IDENTITY_OPTS_TEMP)[pickerView.selectedRow(inComponent: 0)].value
            if row < array.count {
               self.value = array[row]
            }
        }
        self.pickerViewTextField.text =  self.key + ", " + self.value
    }
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
