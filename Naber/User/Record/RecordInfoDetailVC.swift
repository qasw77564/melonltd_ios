//
//  RecordInfoDetailViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RecordInfoDetailVC: UIViewController {



    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalPayment: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var recordTime: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var memoInfo: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        name?.text = storeName
//        uiTotalPayment?.text = totalPayment
//        uiOrderTime?.text = orderTime
//        uiRecordTime?.text = recordTime
//        address?.text = address
//        uiMemoInfo?.text = memoInfo
//        uiBonusNumber?.text = bonusNumber

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
