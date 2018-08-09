//
//  StoreDetailSettingTVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/8/8.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class StoreDetailSettingVC : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
 
    var restaurant: RestaurantInfoVo! = RestaurantInfoVo()
    var threeBusinessDate: [String] = ["2018-07-10T00:00:00.0000Z","2018-07-11T00:00:00.0000Z"]
    
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var bulletin: UITextView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        self.loadData(refresh: true)
    }
    
    var startDates: [String] = ["00","00"]
    var endDates: [String] = ["00","00"]
    
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
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
            let doneBtn = UIBarButtonItem(title: "完成" , style: .done, target: self, action: #selector(onDoneBtn))
            let cancelBtn = UIBarButtonItem(title: "取消" , style: .plain, target: self, action: #selector(onCancelBtn))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolbar.items = [cancelBtn, space, doneBtn]
            toolbar.barTintColor = UIColor.white
            return toolbar
        }
    }
    
    @objc func onDoneBtn(sender: UIBarButtonItem) {
        if self.startDate.isEditing {
            self.startDate.text = self.startDates[0] + ":" + self.startDates[1]
        } else {
            self.endDate.text = self.endDates[0] + ":" + self.endDates[1]
        }
        
        self.view.endEditing(true)
    }
    
    @objc func onCancelBtn(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.startDate.inputView = self.pickerView
        self.startDate.inputAccessoryView = self.accessoryToolbar
        self.endDate.inputView = self.pickerView
        self.endDate.inputAccessoryView = self.accessoryToolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData(refresh: true)
    }
    
    func loadData(refresh: Bool){
        // 取得現在後三天的每日開始時間範圍
        self.threeBusinessDate.removeAll()
        for i in 0..<3 {
            self.threeBusinessDate.append(DateTimeHelper.startOfDate(day: i))
        }
        
        ApiManager.sellerRestaurantInfo(ui: self, onSuccess: { restaurant in
            self.restaurant = restaurant
            print(RestaurantInfoVo.toJson(structs: self.restaurant))
            // 接單開關時間
            self.startDate.text = self.restaurant.store_start
            self.endDate.text = self.restaurant.store_end
            // 公告
            self.bulletin.text = self.restaurant.bulletin
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sbmitEdit(_ sender: UIButton) {
        if self.startDate.text == self.endDate.text {
            let alert = UIAlertController(title: Optional.none, message: "接單時間開始與結束，\n不可以相同。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "我知道了", style: .default))
            self.present(alert, animated: false)
        }else {
            self.restaurant.store_start = self.startDate.text
            self.restaurant.store_end = self.endDate.text
            self.restaurant.bulletin = self.bulletin.text
            ApiManager.sellerRestaurantSetting(req: self.restaurant, ui: self, onSuccess: { restaurant in
                self.restaurant = restaurant
                self.tableView.reloadData()
            }) { err_msg in
                print(err_msg)
            }
        }
    }
    
    @IBAction func logout(_ sender: UIButton) {
        ApiManager.logout(structs: UserSstorage.getAccount(), ui: self, onSuccess: {
            UserSstorage.clearUserData()
            if let vc = UIStoryboard(name: UIIdentifier.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                self.present(vc, animated: false, completion: nil)
            }
        }) { err_msg in
            print(err_msg)
        }
    }
    
    @IBAction func changeDateStatus(_ sender: UISwitch){
        let reqData: ReqData = ReqData()
        reqData.date = self.threeBusinessDate[sender.tag]
        reqData.status = sender.isOn ? "OPEN" : "CLOSE"
        ApiManager.sellerRestaurantSettingBusiness(req: reqData, ui: self, onSuccess: {
            if !sender.isOn {
                self.restaurant.not_business.append(reqData.date)
            }else {
                if let index = self.restaurant.not_business.index(of: reqData.date) {
                    self.restaurant.not_business.remove(at: index)
                }
            }
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
            sender.isOn = !sender.isOn
        }
    }

    // table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.threeBusinessDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! StoreDetailSettingDateCell
        let status: Bool = self.restaurant.not_business.contains(self.threeBusinessDate[indexPath.row])
        cell.weekName.text = "(" + DateTimeHelper.getWeekDate(date: self.threeBusinessDate[indexPath.row]) + ")"
        cell.dateName.text = DateTimeHelper.formToString(date: self.threeBusinessDate[indexPath.row], from: "MM/dd")
        cell.status.tag = indexPath.row
        cell.status.isOn = !status
        return cell
    }
    
    // date select pick
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NaberConstant.HOUR_MINUTE_OPT[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return NaberConstant.HOUR_MINUTE_OPT[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.startDate.isEditing {
            self.startDates[component] = NaberConstant.HOUR_MINUTE_OPT[component][row]
        }else {
            self.endDates[component] = NaberConstant.HOUR_MINUTE_OPT[component][row]
        }
    }
}
