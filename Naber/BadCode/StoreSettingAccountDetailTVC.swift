//
//  StoreSettingAccountDetailTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingAccountDetailTVC: UITableViewController {
    
    var hourArray = ["00","01","02","03","04","05","06","07","08", "09", "10", "11", "12","13","14","15","16","17","18","19","20","21", "22", "23"]
    var minuteArray = ["00","30"]
    var lastSelectedCube = 0
    
   
    
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
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        if startDateTextField.isFirstResponder {
            oldStartDateText = startDateTextField.text!
            startDateTextField.resignFirstResponder()
        }
        
        if endDateTextField.isFirstResponder {
            oldEndDateText = endDateTextField.text!
            endDateTextField.resignFirstResponder()
        }
        
    }
    
    @objc func onCancelButtonTapped(sender: UIBarButtonItem) {
        if startDateTextField.isFirstResponder {
            startDateTextField.text = oldStartDateText
            startDateTextField.resignFirstResponder()
            
        }
        
        if endDateTextField.isFirstResponder {
            endDateTextField.text = oldEndDateText
            endDateTextField.resignFirstResponder()
        }
        
        
    }
    
    var oldStartDateText:String = ""
    var oldEndDateText:String = ""
    
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.delegate = self
        oldStartDateText = startDateTextField.text!
        oldEndDateText = endDateTextField.text!
        
        startDateTextField.inputView = pickerView
        startDateTextField.inputAccessoryView = accessoryToolbar
        endDateTextField.inputView = pickerView
        endDateTextField.inputAccessoryView = accessoryToolbar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sbmiEdit(_ sender: UIButton) {
        
    }
    
    @IBAction func sbmitEdit(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
//        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
//            present(vc, animated: false, completion: nil)
//        }
    }
}

extension StoreSettingAccountDetailTVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hourArray.count
        } else {
            
            return minuteArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return hourArray[row]
        } else {
            return minuteArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            lastSelectedCube = row
            pickerView.reloadComponent(1)
        }
        let hourIndex = pickerView.selectedRow(inComponent: 0)
        let minuteIndex = pickerView.selectedRow(inComponent: 1)
        let buttonText = hourArray[hourIndex]+":"+minuteArray[minuteIndex]
        
        if startDateTextField.isFirstResponder {
            startDateTextField.text = buttonText
        }
        
        if endDateTextField.isFirstResponder {
            endDateTextField.text = buttonText
        }
        
        
    }
    
    
}

