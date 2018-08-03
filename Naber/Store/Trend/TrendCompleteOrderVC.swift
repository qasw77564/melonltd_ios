//
//  TrendCompleteOrderViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class TrendCompleteOrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var startSelect: UITextField!
    @IBOutlet weak var endSelect: UITextField!
    
    @IBOutlet weak var tabelView: UITableView! {
        didSet{
            self.tabelView.delegate = self
            self.tabelView.dataSource = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tabelView.addSubview(refreshControl)
        }
    }
    
    var startDatePicker: UIDatePicker {
        get {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.locale = Locale.init(identifier: "zh_TW")
            datePicker.timeZone = TimeZone.init(identifier: "Asia/Taipei")
            self.reTimeRange(picker: datePicker)
            datePicker.tag = 0
            datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
            datePicker.backgroundColor = UIColor.white
            return datePicker
        }
    }
    
    var startToolbar: UIToolbar {
        get {
            let accessory = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
            let doneBtn = UIBarButtonItem(title: "完成" , style: .done, target: self,action: #selector(onToolbarDone))
            doneBtn.tag = 0
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelBtn = UIBarButtonItem(title:"取消" , style: .plain, target: self,action: #selector(onToolbarCancel))
            cancelBtn.tag = 0
            accessory.items = [cancelBtn, space , doneBtn]
            accessory.barTintColor = UIColor.white
            return accessory
        }
    }
    
    var endDatePicker: UIDatePicker {
        get {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.locale = Locale.init(identifier: "zh_TW")
            datePicker.timeZone = TimeZone.init(identifier: "Asia/Taipei")
            self.reTimeRange(picker: datePicker)
            datePicker.tag = 1
            datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
            datePicker.backgroundColor = UIColor.white
            return datePicker
        }
    }
    
    var endToolbar: UIToolbar {
        get {
            let accessory = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
            let doneBtn = UIBarButtonItem(title: "完成" , style: .done, target: self, action: #selector(onToolbarDone))
            doneBtn.tag = 1
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelBtn = UIBarButtonItem(title:"取消" , style: .plain, target: self,action: #selector(onToolbarCancel))
            cancelBtn.tag = 1
            accessory.items = [cancelBtn, space , doneBtn]
            accessory.barTintColor = UIColor.white
            return accessory
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startSelect.inputView = self.startDatePicker
        self.startSelect.inputAccessoryView = self.startToolbar
        self.endSelect.inputView = self.endDatePicker
        self.endSelect.inputAccessoryView = self.endToolbar
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        self.loadData(refresh: true)
    }
    
    func loadData(refresh: Bool){
        
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        if sender.tag == 0 {
            self.startSelect.tag = self.getMiliseconds(data: sender.date)
            self.startSelect.text = DateTimeHelper.dateToStringForm(date: sender.date, form: "yyyy年 MM月 dd日")
        } else {
            self.endSelect.tag = self.getMiliseconds(data: sender.date)
            self.endSelect.text = DateTimeHelper.dateToStringForm(date: sender.date, form: "yyyy年 MM月 dd日")
        }
    }
    
    @objc func onToolbarDone(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            print(self.startSelect.tag)
            self.startSelect.endEditing(true)
        } else {
            print(self.endSelect.tag)
            self.endSelect.endEditing(true)
        }
    }
    
    @objc func onToolbarCancel(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            self.startSelect.endEditing(true)
        } else {
            self.endSelect.endEditing(true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! TrendCompleteOrderTVCell
        
        return cell
    }
    
    func reTimeRange (picker: UIDatePicker){
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.init(identifier: "Asia/Taipei")!
        calendar.locale = Locale.init(identifier: "zh_TW")
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.month = 0
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        picker.maximumDate = maxDate
        components.month = -2
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        picker.minimumDate = minDate
    }
    
    
    func getMiliseconds(data: Date) -> Int {
        let nowDouble = data.timeIntervalSince1970
        return Int(nowDouble * 1000)
    }

}

