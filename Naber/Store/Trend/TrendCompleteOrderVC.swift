//
//  TrendCompleteOrderViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class CellData {
    var orderStatus:String = ""
    var orderMoney:String = ""
    var telephone:String = ""
    var name:String = ""
}

//UNFINISH,PROCESSING,CAN_FETCH,FINISH,CANCEL,FAIL
//未處理、製作中、可領取、交易完成、取消、跑單

class TrendCompleteOrderVC: UIViewController {
    
    var cellDatas = [CellData]()
    
    @IBOutlet weak var resultTable: UITableView!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    var oldStartDateText:String = ""
    
    var oldEndDateText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTable.delegate = self
        resultTable.dataSource = self
        setupDate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    

    
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
            
            
            let currentDate: Date = Date()
            var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
            calendar.timeZone = TimeZone(identifier: "UTC")!
            var components: DateComponents = DateComponents()
            components.calendar = calendar
            components.month = 0
            let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
            components.month = -2
            let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
            
            print("minDate: \(minDate)")
            print("maxDate: \(maxDate)")
            
            datePicker.addTarget(self,
                                 action: #selector(onDateChanged(sender:)),
                                 for: .valueChanged)
            datePicker.backgroundColor = UIColor.white
            
            
            return datePicker
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
    
    func setupDate(){
        
        
        startDateTextField.inputView = datePicker
        startDateTextField.inputAccessoryView = accessoryToolbar
        
        endDateTextField.inputView = datePicker
        endDateTextField.inputAccessoryView = accessoryToolbar
        
        
        let data1 = CellData()
        data1.orderStatus = "FINISH"
        data1.orderMoney = "$999999"
        data1.telephone = "0975123456"
        data1.name = "某某某"
        
        let data2 = CellData()
        data2.orderStatus = "CANCEL"
        data2.orderMoney = "$999991"
        data2.telephone = "0975123456"
        data2.name = "某某某"
        
        cellDatas.append(data1)
        cellDatas.append(data2)
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        if startDateTextField.isFirstResponder {
            startDateTextField.text = sender.date.mediumDateString
        }
        if endDateTextField.isFirstResponder {
            endDateTextField.text = sender.date.mediumDateString
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
            startDateTextField.resignFirstResponder()
            startDateTextField.text = oldStartDateText
        }
        if endDateTextField.isFirstResponder {
            endDateTextField.text = oldEndDateText
            endDateTextField.resignFirstResponder()
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if startDateTextField.isFirstResponder {
            startDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        if endDateTextField.isFirstResponder {
            endDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
    }
    
    
}

extension TrendCompleteOrderVC : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrendCompleteOrderTVCell
        
        cell.buyerName.text = cellDatas[indexPath.row].name
        cell.buyerPhone.text = cellDatas[indexPath.row].telephone
        
        cell.orderMoney.text = cellDatas[indexPath.row].orderMoney
        
        switch cellDatas[indexPath.row].orderStatus {
        case "FINISH":
            cell.orderStatus.setTitle("交易完成", for: .normal)
        case "CANCEL":
            cell.orderStatus.setTitle("取消", for: .normal)
            cell.orderStatus.backgroundColor = UIColor.red
        default:
            break
        }
        
        return cell
    }
    
}
