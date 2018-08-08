//
//  StoreSettingMainPageTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreSettingMainPageTVC: UITableViewController {

    
    @IBOutlet weak var account: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiManager.bulletin(ui: self, onSuccess: { bulletins in
            print(bulletins)
        }) { err_msg in
            print(err_msg)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.account.text = UserSstorage.getAccount()?.account
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
