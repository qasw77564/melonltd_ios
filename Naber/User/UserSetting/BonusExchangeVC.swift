//
//  BonusExchangeVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/8/2.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//


import UIKit


class BonusExchangeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var datas : [[String]] = []
    var activities: [ActivitiesVo] = []
    
//    @IBOutlet var eventDescription: UILabel!
    @IBOutlet var eventContent: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        self.loadData(refresh: true) {
            sender.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    
    func loadData (refresh: Bool, complete: @escaping () -> ()){
        if refresh {
            self.activities.removeAll()
            self.tableView.reloadData()
        }
        
        let test: [SubjectionRegionVo] = SubjectionRegionVo.parseArray(src: NaberConstant.SUBJECTION_REGIONS)
        print(test.description)
        
        ApiManager.getSubjectionRegions(ui: self, onSuccess: { regions in
            print(regions)
        }) { err_msg in
            print(err_msg)
        }
        
        ApiManager.getAllActivities(ui: self, onSuccess: { activities in
            self.activities.append(contentsOf: activities)
            complete()
        }) { err_msg in
            print(err_msg)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.textData()
        self.loadData(refresh: true) {
            self.tableView.reloadData()
        }
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        ApiManager.getAllActivities(ui: self, onSuccess: { activities in
//            self.activities.append(contentsOf: activities)
//            self.tableView.reloadData()
//        }) { err_msg in
//            print(err_msg)
//        }
//    }
//
    func textData (){
        self.eventContent.text =
        "凡是透過NABER訂餐，\n一律回饋消費金額之10%紅利點數\n" +
        "，並能兌換NABER所提供之獎勵。\n\n" +
        "* 10月起 開放兌換獎勵及現金折抵\n" +
        "* 消費10元獲得1點紅利點數\n"

        self.datas.append(contentsOf:[["10點", "下次消費折抵3元" ,"(無上限)"],
                                ["500點", "KKBOX 30天","(點數卡)"],
                                ["667點", "中壢威尼斯","(電影票)"],
                                ["767點", "桃園IN89統領","(電影票)"],
                                ["767點", "美麗華影城","(電影票)"],
                                ["800點", "LINE 240P","(點數卡)"],
                                ["834點", "SBC星橋","(電影票)"],
                                ["834點", "威秀影城","(電影票)"],
                                ["1000點", "SOGO 300","(禮卷)"],
                                ["1000點", "MYCARD 300P","(點數卡)"]])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Cell 所需數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activities.count
    }
    
    //回傳 Ｃell 樣式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIIdentifier.CELL.rawValue, for: indexPath) as! BonusExchangeTVCell
        cell.point.text = self.activities[indexPath.row].need_bonus
        cell.productName.text = self.activities[indexPath.row].title
        cell.remarks.text = self.activities[indexPath.row].content_text
        return cell
    }
    
    // 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: UIIdentifier.USER.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ActivitiesSendSubmitVC") as? ActivitiesSendSubmitVC {
            vc.act = self.activities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
