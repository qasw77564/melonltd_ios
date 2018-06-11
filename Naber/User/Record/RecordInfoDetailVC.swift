//
//  RecordInfoDetailViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RecordInfoDetailVC: UIViewController {

    var storeName:String = ""
    var totalPayment:String = ""
    var orderTime:String = ""
    var recordTime:String = ""
    var address:String = ""
    var memoInfo:String = ""
    var bonusNumber:String = ""

    @IBOutlet weak var uiStoreName: UILabel!
    @IBOutlet weak var uiTotalPayment: UILabel!
    @IBOutlet weak var uiOrderTime: UILabel!
    @IBOutlet weak var uiRecordTime: UILabel!
    @IBOutlet weak var uiAddress: UILabel!
    @IBOutlet weak var uiMemoInfo: UILabel!
    @IBOutlet weak var uiBonusNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiStoreName?.text = storeName
        uiTotalPayment?.text = totalPayment
        uiOrderTime?.text = orderTime
        uiRecordTime?.text = recordTime
        uiAddress?.text = address
        uiMemoInfo?.text = memoInfo
        uiBonusNumber?.text = bonusNumber

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
