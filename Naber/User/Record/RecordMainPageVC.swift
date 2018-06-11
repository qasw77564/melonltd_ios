//
//  RecordMainPageViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RecordInfoClass {
    
    var storeName:String = ""
    var time:String = ""
    var recordTime:String = ""
    var totalPayment = ""
 
}

class RecordMainPageVC: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    var recordInfos = [RecordInfoClass]()

    @IBOutlet weak var recordTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        recordTableView.delegate = self
        recordTableView.dataSource = self
        
        
        let recordInfo = RecordInfoClass()
        recordInfo.storeName="測試店家"
        recordInfo.time="營業時間10:00~11:00"
        recordInfo.recordTime="24日15點22分";
        recordInfo.totalPayment="$340";

        recordInfos.append(recordInfo)
        recordInfos.append(recordInfo)
        recordInfos.append(recordInfo)
        recordInfos.append(recordInfo)
        recordInfos.append(recordInfo)
        recordInfos.append(recordInfo)
        
        
        for record in recordInfos {
            print(record.storeName)
            print(record.time)
            print(record.recordTime)
            print(record.totalPayment)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecordInfoDetailTVCell
        cell.storeName.text = recordInfos[indexPath.row].storeName
        cell.time.text = recordInfos[indexPath.row].time
        cell.recordTime.text = recordInfos[indexPath.row].recordTime
        cell.totalPayment.text = recordInfos[indexPath.row].totalPayment
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RecordInfoDetailVC
        {
            let vc = segue.destination as? RecordInfoDetailVC
            vc?.storeName = "測試店家名稱"
            vc?.totalPayment = "300"
            vc?.orderTime = "10日08點08分"
            vc?.recordTime = "10日10點10分"
            vc?.address = "203基隆市中山區中山一路1號"
            vc?.memoInfo = "備註"
            vc?.bonusNumber =  "12"
       
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return storeName.count
        return recordInfos.count
        
    }
    

}
