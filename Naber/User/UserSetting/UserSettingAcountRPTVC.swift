//
//  UserSettingAcountResetPasswordTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/25.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingAcountRPTVC: UITableViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitAction(_ sender: UIButton) {
        // TODO 做驗證輸入，並呼叫API
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
