//
//  OrderMainVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class CustomerUIColor {
    
    static let lightRed = UIColor(red: 255/255.0, green: 115/255.0, blue: 35/255.0, alpha: 1.0)
    static let lightYellow = UIColor(red: 255/255.0, green: 239/255.0, blue: 3/255.0, alpha: 1.0)
    
    static let lightGreen = UIColor(red: 6/255.0, green: 255/255.0, blue: 2/255.0, alpha: 1.0)
    
    static let darkYellow = UIColor(red: 234/255.0, green: 228/255.0, blue: 79/255.0, alpha: 1.0)
    
    static let red = UIColor(red: 234/255.0, green: 25/255.0, blue: 33/255.0, alpha: 1.0)

    static let purple = UIColor(red: 121/255.0, green: 113/255.0, blue: 189/255.0, alpha: 1.0)


}

class OrderMainVC: UIViewController {
    
    var isSlideMenuHidden = true

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var orderMainTable: UITableView!
    
    @IBOutlet weak var selectNumber1: UILabel!
    
    @IBOutlet weak var selectNumber2: UILabel!
    
    @IBOutlet weak var selectNumber3: UILabel!
    
    @IBOutlet weak var selectButton1: UIButton!
    
    @IBOutlet weak var selectButton2: UIButton!
    
    @IBOutlet weak var selectButton3: UIButton!
    
    var selectButtonStatus :Int = 1
    
    @IBOutlet weak var dateTextField: UITextField!
    
    var oldDateTextField:String = ""


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

    @objc func onDateChanged(sender: UIDatePicker) {
            dateTextField.text = sender.date.mediumDateString
    }
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
            oldDateTextField = dateTextField.text!
            dateTextField.resignFirstResponder()
    }
    
    @objc func onCancelButtonTapped(sender: UIBarButtonItem) {
            dateTextField.text = oldDateTextField
            dateTextField.resignFirstResponder()
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // initialize constant with 0
        orderMainTable.delegate=self
        orderMainTable.dataSource=self

        sideMenuConstraint.constant = -200
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = accessoryToolbar
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func selectButton1Click(_ sender: Any) {
        selectButton1.backgroundColor = CustomerUIColor.darkYellow
        selectButton1.setTitleColor(UIColor.white, for: .normal)
        selectButton2.backgroundColor = UIColor.lightGray
        selectButton2.setTitleColor(UIColor.black, for: .normal)
        selectButton3.backgroundColor = UIColor.lightGray
        selectButton3.setTitleColor(UIColor.black, for: .normal)
        selectButtonStatus = 1
        orderMainTable.reloadData()
    }
    
    @IBAction func selectButton2Click(_ sender: Any) {
        selectButton1.backgroundColor = UIColor.lightGray
        selectButton1.setTitleColor(UIColor.black, for: .normal)
        selectButton2.backgroundColor = CustomerUIColor.darkYellow
        selectButton2.setTitleColor(UIColor.white, for: .normal)
        selectButton3.backgroundColor = UIColor.lightGray
        selectButton3.setTitleColor(UIColor.black, for: .normal)
        selectButtonStatus = 2
        orderMainTable.reloadData()
    }
    
    @IBAction func selectButton3Click(_ sender: Any) {
        selectButton1.backgroundColor = UIColor.lightGray
        selectButton1.setTitleColor(UIColor.black, for: .normal)
        selectButton2.backgroundColor = UIColor.lightGray
        selectButton2.setTitleColor(UIColor.black, for: .normal)
        selectButton3.backgroundColor = CustomerUIColor.darkYellow
        selectButton3.setTitleColor(UIColor.white, for: .normal)
        selectButtonStatus = 3
        orderMainTable.reloadData()
    }
    
    
    @IBAction func organizeBtnPressed(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            sideMenuConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else {
            sideMenuConstraint.constant = -200
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
    }
    
}

extension OrderMainVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OrderMainTVCell

        cell.itemList.text = "雞腿    x1    $10\n雞腿    x1    $10\n雞腿    x1    $10"
        
        
        cell.itemNumberAndStatus.text="未處理訂單0"
        
        cell.memoList.text="未處理訂單0\n未處理訂單0\n未處理訂單0\n未處理訂單0\n未處理訂單0\n"
        
        
        switch selectButtonStatus {
            case 1:
                cell.button1.setTitleColor(UIColor.white, for: .normal)
                cell.button2.setTitleColor(UIColor.white, for: .normal)
                cell.button3.setTitleColor(UIColor.white, for: .normal)
                cell.button1.backgroundColor = CustomerUIColor.red
                cell.button2.backgroundColor = CustomerUIColor.lightRed
                cell.button3.backgroundColor = CustomerUIColor.lightYellow

                cell.button1.setTitle("取消", for: .normal)
                cell.button2.setTitle("製作中", for: .normal)
                cell.button3.setTitle("可領取", for: .normal)


            case 2:
                cell.button1.setTitleColor(UIColor.white, for: .normal)
                cell.button2.setTitleColor(UIColor.white, for: .normal)
                cell.button3.setTitleColor(UIColor.white, for: .normal)

                cell.button1.backgroundColor = CustomerUIColor.red
                cell.button2.backgroundColor = CustomerUIColor.lightYellow
                cell.button3.backgroundColor = CustomerUIColor.lightGreen

                cell.button1.setTitle("取消", for: .normal)
                cell.button2.setTitle("可領取", for: .normal)
                cell.button3.setTitle("交易完成", for: .normal)



        case 3:
                cell.button1.setTitleColor(UIColor.white, for: .normal)
                cell.button2.setTitleColor(UIColor.white, for: .normal)
                cell.button3.setTitleColor(UIColor.white, for: .normal)

                cell.button1.backgroundColor = CustomerUIColor.red
                cell.button2.backgroundColor = CustomerUIColor.red
                cell.button3.backgroundColor = CustomerUIColor.lightGreen

                cell.button1.setTitle("取消", for: .normal)
                cell.button2.setTitle("跑單", for: .normal)
                cell.button3.setTitle("交易完成", for: .normal)

            default:break
        }

        
        
        return cell
    }

    
}
