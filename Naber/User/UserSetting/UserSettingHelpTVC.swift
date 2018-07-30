//
//  UserSettingHelpTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/25.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingHelpTVC: UITableViewController {

    @IBOutlet weak var contactUsText: UILabel!
    @IBOutlet weak var faqText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let s1: String = Model.ALL_BULLETINS["FAQ"]!
//        let text1: String = StringsHelper.replace(str: s1, of: "/n", with: "$split")
//        self.text1.text = text1
//
//        let s2: String = Model.ALL_BULLETINS["FAQ"]!
//        let text2: String = StringsHelper.replace(str: s2, of: "/n", with: "$split")
//        self.text2.text = text2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
