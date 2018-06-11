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
    
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var pickerViewTextField : UITextField!
    private var customerIdentifyDataPicker: UIPickerView!
    
    var oldIdentityText : String?
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
    
    let cubesToWorkWith = ["小學生", "國中生","高中生","大學/大專院校生","社會人士"]
    let juniorHighSchool = ["國中一","國中二","國中三","國中四","國中五"]
    let seniorHighSchool = ["高中一","高中二","高中三","高中四"]
    let colloge = ["大學一","大學二","大學三","大學四"]
    var lastSelectedCube = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
    func setupUI(){
        datePickerTextField.inputView = datePicker
        datePickerTextField.inputAccessoryView = accessoryToolbar
        // Giving the date picker text field an initial value.
        
        
        
        pickerViewTextField.inputView = pickerView
        pickerViewTextField.inputAccessoryView = accessoryToolbar
        
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        datePickerTextField.text = sender.date.mediumDateString
    }
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        if datePickerTextField.isFirstResponder {
            oldBirthDateText = datePickerTextField.text
            datePickerTextField.resignFirstResponder()
        }
        
        if pickerViewTextField.isFirstResponder {
            oldIdentityText = pickerViewTextField.text
            pickerViewTextField.resignFirstResponder()
        }
    }
    
    @objc func onCancelButtonTapped(sender: UIBarButtonItem) {
        if datePickerTextField.isFirstResponder {
            datePickerTextField.resignFirstResponder()
            datePickerTextField.text = oldBirthDateText
        }
        
        if pickerViewTextField.isFirstResponder {
            pickerViewTextField.text = oldIdentityText
            pickerViewTextField.resignFirstResponder()
        }
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
        
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

// MARK: - UIPickerView Methods
extension RegisterUserDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return cubesToWorkWith.count
        } else {
            
            if cubesToWorkWith[lastSelectedCube] == "國中生" {
                return juniorHighSchool.count
            } else if cubesToWorkWith[lastSelectedCube] == "高中生" {
                return seniorHighSchool.count
            } else if cubesToWorkWith[lastSelectedCube] == "大學/大專院校生" {
                return colloge.count
            } else /* You did not mention what to show for other selections, that would be handled here */ {
                return 0
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return cubesToWorkWith[row]
        } else {
            if cubesToWorkWith[lastSelectedCube] == "國中生" {
                return juniorHighSchool[row]
            } else if cubesToWorkWith[lastSelectedCube] == "高中生" {
                return seniorHighSchool[row]
            } else if cubesToWorkWith[lastSelectedCube] == "大學/大專院校生" {
                return colloge[row]
            } else /* You did not mention what to show for other selections, that would be handled here */ {
                return "undefined"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            lastSelectedCube = row
            pickerView.reloadComponent(1)
        }
        let idendityIndex = pickerView.selectedRow(inComponent: 0)
        let schoolIndex = pickerView.selectedRow(inComponent: 1)
        
        if cubesToWorkWith[lastSelectedCube] == "國中生" {
            pickerViewTextField.text = cubesToWorkWith[idendityIndex]+","+juniorHighSchool[schoolIndex]
        } else if cubesToWorkWith[lastSelectedCube] == "高中生" {
            pickerViewTextField.text = cubesToWorkWith[idendityIndex]+","+seniorHighSchool[schoolIndex]
        } else if cubesToWorkWith[lastSelectedCube] == "大學/大專院校生" {
            pickerViewTextField.text = cubesToWorkWith[idendityIndex]+","+colloge[schoolIndex]
            
        } else /* You did not mention what to show for other selections, that would be handled here */ {
            pickerViewTextField.text = cubesToWorkWith[idendityIndex]
        }
        
    }
    
    
}
