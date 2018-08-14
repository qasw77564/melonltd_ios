//
//  LeftSideMenuViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/7.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class LeftSideMenuVC: UIViewController {

    var dateRanges: [DateRangeVo] = []
    
    static var tmpDateRanges: [DateRangeVo] = []
    
    @IBOutlet weak var leftSideMenu: UITableView! {
        didSet {
            self.leftSideMenu.dataSource = self
            self.leftSideMenu.delegate = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.leftSideMenu.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        self.loadData(refresh: true)
        sender.endRefreshing()
    }
    
    func loadData(refresh: Bool){
        self.dateRanges.removeAll()
        ApiManager.sellerBusinessTime(ui: self, onSuccess: { dateRanges in
            self.dateRanges.append(contentsOf: dateRanges)
            self.leftSideMenu.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.loadData(refresh: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LeftSideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dateRanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! LeftSideMenuTVCell
        cell.timeSwitch.tag = indexPath.row
        cell.time.text = self.dateRanges[indexPath.row].date
        cell.timeSwitch.setOn(SwitchStatus.of(name: self.dateRanges[indexPath.row].status).status(), animated: true)
        cell.timeSwitch.addTarget(self, action: #selector(changeBusinessTime), for: .valueChanged)
        return cell
    }
    
    @objc func changeBusinessTime(sender : UISwitch!) {
        if sender.isOn != SwitchStatus.of(name: self.dateRanges[sender.tag].status).status() {
            self.dateRanges[sender.tag].status = SwitchStatus.of(bool: sender.isOn)
            let reqData: RestaurantInfoVo = RestaurantInfoVo()
            reqData.can_store_range.append(contentsOf: self.dateRanges)
            ApiManager.sellerChangeBusinessTime(req: reqData, ui: self, onSuccess: { dateRanges in
                self.dateRanges.removeAll()
                self.dateRanges.append(contentsOf: dateRanges)
                self.leftSideMenu.reloadData()
            }) { err_msg in
                self.dateRanges[sender.tag].status = SwitchStatus.of(bool: !sender.isOn)
                self.leftSideMenu.reloadData()
            }
        }
    }
    
}
