//
//  RecordMainPageViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class RecordMainPageVC: UIViewController ,UITableViewDataSource, UITableViewDelegate{



    @IBOutlet weak var tableView: UITableView! {
        didSet{
            
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//
//
//
//
//        recordInfos.append(recordInfo)
//        recordInfos.append(recordInfo)
//        recordInfos.append(recordInfo)
//        recordInfos.append(recordInfo)
//        recordInfos.append(recordInfo)
//        recordInfos.append(recordInfo)
//
//
//        for record in recordInfos {
//            print(record.storeName)
//            print(record.time)
//            print(record.recordTime)
//            print(record.totalPayment)
//        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecordInfoDetailTVCell
//        cell.storeName.text = recordInfos[indexPath.row].storeName
////        cell.time.text = recordInfos[indexPath.row].time
//        cell.recordTime.text = recordInfos[indexPath.row].recordTime
//        cell.totalPayment.text = recordInfos[indexPath.row].totalPayment
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is RecordInfoDetailVC {
            let vc = segue.destination as? RecordInfoDetailVC
           // TODO DATA
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return storeName.count
        return 10
        
    }
    

}
