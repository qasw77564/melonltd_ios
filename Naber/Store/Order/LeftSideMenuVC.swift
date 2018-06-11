//
//  LeftSideMenuViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/7.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
class OrderTimeSwitch {
    var timePeriod:String = ""
    var timeSwitch:Bool = false
    
}
class LeftSideMenuVC: UIViewController {

    var ordertimes = [OrderTimeSwitch]()
    
    var timePeriod:Array = ["PM12:00~PM12:30","PM12:30~AM01:00","AM01:00~AM01:30","AM01:30~AM02:00","AM02:00~AM02:30","AM02:30~AM03:00","AM03:00~AM03:30","AM03:30~AM04:00","AM04:00~AM04:30","AM04:30~AM05:00","AM05:00~AM05:30","AM05:30~AM06:00","AM06:00~AM06:30","AM06:30~AM07:00","AM07:00~AM07:30","AM07:30~AM08:00","AM08:00~AM08:30","AM08:30~AM09:00","AM09:00~AM09:30","AM09:30~AM10:00","AM10:00~AM10:30","AM10:30~AM11:00","AM11:00~AM11:30","AM11:30~AM12:00","AM12:00~AM12:30","AM12:30~PM01:00","PM01:00~PM01:30","PM01:30~PM02:00","PM02:00~PM02:30","PM02:30~PM03:00","PM03:00~PM03:30","PM03:30~PM04:00","PM04:00~PM04:30","PM04:30~PM05:00","PM05:00~PM05:30","PM05:30~PM06:00","PM06:00~PM06:30","PM06:30~PM07:00","PM07:00~PM07:30","PM07:30~PM08:00","PM08:00~PM08:30","PM08:30~PM09:00","PM09:00~PM09:30","PM09:30~PM10:00","PM10:00~PM10:30","PM10:30~PM11:00","PM11:00~PM11:30","PM11:30~PM12:00"]
    
    @IBOutlet weak var leftSideMenu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leftSideMenu.delegate = self
        leftSideMenu.dataSource = self
        setupData ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData (){
        
        for timeWord in timePeriod {
            let orderTime = OrderTimeSwitch()
            orderTime.timePeriod=timeWord
            orderTime.timeSwitch=false
            ordertimes.append(orderTime)
        }
      
    }
    

}

extension LeftSideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordertimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeftSideMenuTVCell
        cell.time.text = ordertimes[indexPath.row].timePeriod
        cell.timeSwitch.setOn( ordertimes[indexPath.row].timeSwitch , animated: false)
        cell.timeSwitch.tag = indexPath.row
        cell.timeSwitch.addTarget(self, action: #selector(timeSwitchMethod(sender:)), for: .touchUpInside)

        return cell
    }
    
    @objc func timeSwitchMethod(sender : UISwitch!) {
        ordertimes[sender.tag].timeSwitch = sender.isOn
        leftSideMenu.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
    
}
