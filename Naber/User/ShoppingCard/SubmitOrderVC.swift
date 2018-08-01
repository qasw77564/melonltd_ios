//
//  SubmitOrderVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/31.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
class SubmitOrderVC : UIViewController {

    
    var datePicker: UIDatePicker {
        get {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
//            // 設置 NSDate 的格式
//            let formatter = DateFormatter()
//            // 設置時間顯示的格式
//            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            // 設置顯示的語言環境
            datePicker.locale = Locale.init(identifier: "zh_TW")
//            let currentDate: Date = Date()
//            var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//            calendar.timeZone = TimeZone(identifier: "UTC")!
//            var components: DateComponents = DateComponents()
//            components.calendar = calendar
//            components.day = 3
//            let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
//            components.day = 0
//            let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
//            datePicker.minimumDate = minDate
//            datePicker.maximumDate = maxDate
            self.reTimeRange(picker: datePicker)
            datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
            datePicker.backgroundColor = UIColor.white
            return datePicker
        }
    }
    @IBOutlet weak var dateSelect: UITextField! {
        didSet {
           dateSelect.inputView = self.datePicker
        }
    }
    
    @objc func onDateChanged(sender: UIDatePicker) {
        self.dateSelect.text = DateTimeHelper.dateToStringForm(date: sender.date, form: "yyyy-MM-dd HH:mm")
    }
    
    @IBOutlet weak var userMssage: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    var orderIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.reTimeRange(picker: self.datePicker)
        let list: [OrderDetail] = UserSstorage.getShoppingCartDatas()
        let orderDates: [OrderData] = list[self.orderIndex].orders
        self.name.text = list[self.orderIndex].user_name
        self.phone.text = list[self.orderIndex].user_phone
        let price: Double = orderDates.reduce(0.0, { (sum, num) -> Double in
            return sum + Double(num.item.price)!
        })
        self.price.text = "$" + Int(price).description
        self.bonus.text = "應得紅利 " + Int(floor(price / 10.0)).description
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        let dateString: String = DateTimeHelper.formToString(date: self.dateSelect.text!, fromDate: "yyyy-MM-dd HH:mm")
        print(dateString)
    }
    
    
    @IBAction func selectTimePicker(_ sender: UITextField) {
        
    }
    
    func reTimeRange (picker: UIDatePicker){
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.day = 3
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        picker.maximumDate = maxDate
        components.day = 0
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        picker.minimumDate = minDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}
