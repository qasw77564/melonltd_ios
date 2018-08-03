//
//  TrendOrderLogDetailVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/8/4.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import Foundation
import UIKit
class TrendOrderLogDetailVC : UIViewController {
    
    
    var order: OrderVo!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalPayment: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var recordTime: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var memoInfo: UILabel!
    @IBOutlet weak var bonus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.order)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
