//
//  SubmitOrderVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/31.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
class SubmitOrderVC : UIViewController {

    var orderIndex: Int!
    var datePicker: UIDatePicker {
        get {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.locale = Locale.init(identifier: "zh_TW")
            datePicker.timeZone = TimeZone.init(identifier: "Asia/Taipei")
            self.reTimeRange(picker: datePicker)
            datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
            datePicker.backgroundColor = UIColor.white
            return datePicker
        }
    }
    
    @IBOutlet weak var dateSelect: UITextField! {
        didSet {
           self.dateSelect.inputView = self.datePicker
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.reTimeRange(picker: self.datePicker)
        self.dateSelect.text = ""
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
  
        if self.dateSelect.text == "" {
            let alert = UIAlertController(title: "", message: "請選擇取餐時間", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default){ _ in

            })
            self.present(alert, animated: false)
        }else {
            let detail: OrderDetail = UserSstorage.getShoppingCartDatas()[self.orderIndex]
            detail.fetch_date = DateTimeHelper.formToString(date: self.dateSelect.text!, fromDate: "yyyy-MM-dd HH:mm")
            detail.user_message = self.userMssage.text

            ApiManager.userOrderSubmit(req: detail, ui: self, onSuccess: {
                // 提交訂單成功 把該筆訂單從手機記憶中移除
                var shoppingCartData: [OrderDetail] = UserSstorage.getShoppingCartDatas()
                shoppingCartData.remove(at: self.orderIndex)
                UserSstorage.setShoppingCartDatas(datas: shoppingCartData)
                
                let msg: String = "商家已看到您的訂單囉！\n" +
                                "你可前往訂單頁面查看商品狀態，\n" +
                                "提醒您，商品只保留至取餐時間後20分鐘。"
                let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: { _ in
                    // 跳制訂記錄頁面
                    self.tabBarController?.selectedIndex = 3
                    // 把當前畫面返回到購物車列表
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 2])!, animated: true)
                }))

                self.present(alert, animated: false)
            }) { err_msg in
                let alert = UIAlertController(title: "", message: StringsHelper.replace(str: err_msg, of: "$split", with: "\n"), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "我知道了", style: .default))
                self.present(alert, animated: false)
            }
        }
    }
    
    @IBAction func selectTimePicker(_ sender: UITextField) {
        
    }
    
    func reTimeRange (picker: UIDatePicker){
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.init(identifier: "Asia/Taipei")!
        calendar.locale = Locale.init(identifier: "zh_TW")
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.day = 3
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        picker.maximumDate = maxDate
        components.day = 0
        components.minute = 20
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
