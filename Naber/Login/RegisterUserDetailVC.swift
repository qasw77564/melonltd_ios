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
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var PasswordCKField: UITextField!
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
//    {
//    "password": "a123456",
//    "name": "seller test",
//    "email": "evan.wang@melonltd.com.tw",
//    "phone": "0928297071",
//    "address": "桃園市平鎮區文化街217號",
//    "birth_day": "1988/04/06",
//    "identity": ""
//    }
    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.key = Array(NaberConstant.IDENTITY_OPTS_TEMP)[0].key
        self.value = NaberConstant.IDENTITY_OPTS_TEMP[key]![0]
        self.pickerViewTextField.text =  self.key + ", " + self.value
        
        setupUI()
    }
//    private func verifyInput() -> String{
//        if(register_name.text != nil){
//
//        }else {
//
//        }
//    }
    
    
//    private func verifyInput () -> String {
//        var msg: String = ""
//        if self.account_text.text == "" {
//            msg = "請輸入帳號"
//        }
//        if self.password_text.text == "" {
//            msg = "請輸入密碼"
//        }
//        if msg != "" {
//            let alert = UIAlertController(title: "系統提示", message: msg, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "取消", style: .default))
//            self.present(alert, animated: false)
//        }
//        return msg
//    }

//    private boolean verifyInput() {
//    boolean result = true;
//    String message = "";
//    // 驗證身份不為空
//    if (Strings.isNullOrEmpty(identityText.getText().toString())) {
//    message = "驗證身份不為空";
//    result = false;
//    }
//    // 驗證姓名不為空
//    if (Strings.isNullOrEmpty(nameEditText.getText().toString())) {
//    message = "姓名不為空";
//    result = false;
//    }
//    // 驗證姓名長度大於二
//    if (nameEditText.getText().toString().length() <= 1 || nameEditText.getText().toString().length() >= 5) {
//    message = "姓名格式不正確";
//    result = false;
//    }
//    // 驗證Email不為空
//    //        if (Strings.isNullOrEmpty(emailEditText.getText().toString())) {
//    //            message = "Email不為空";
//    //            result = false;
//    //        }
//    // 驗證Email錯誤格式
//    //        if (!VerifyUtil.email(emailEditText.getText().toString())) {
//    //            message = "Email錯誤格式";
//    //            result = false;
//    //        }
//    // 驗證密碼不為空 並需要英文大小寫數字 6 ~ 20
//    if (!VerifyUtil.password(passwordEditText.getText().toString())) {
//    message = "密碼不為空 並需要英文大小寫數字 6 ~ 20";
//    result = false;
//    }
//    // 驗證密碼與確認密碼一致
//    if (!passwordEditText.getText().toString().equals(confirmPasswordEditText.getText().toString())) {
//    message = "密碼與確認密碼一致";
//    result = false;
//    }
//    // 驗證生日不為空
//    //        if (Strings.isNullOrEmpty(birthdayText.getText().toString())) {
//    //            message = "生日不為空";
//    //            result = false;
//    //        }
//    if (!result) {
//    new AlertView.Builder()
//    .setTitle("")
//    .setMessage(message)
//    .setContext(getContext())
//    .setStyle(AlertView.Style.Alert)
//    .setCancelText("取消")
//    .build()
//    .setCancelable(true)
//    .show();
//    }
//
//    return result;
//    }
    
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
        let alert = UIAlertController(title: "", message: "確定要送出嗎？",   preferredStyle: .alert)
        let actionTaken = UIAlertAction(title: "確認", style: .default) { (hand) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyBoard.instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
            self.present(destinationVC!, animated: false, completion: nil)
        }
        alert.addAction(actionTaken)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alert, animated: false) {}
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
}
