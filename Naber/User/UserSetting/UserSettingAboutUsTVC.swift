//
//  UserSettingAboutUsTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingAboutUsTVC: UITableViewController {

    @IBOutlet weak var AboutUsText: UILabel!
    @IBOutlet weak var ApplyOfSellerText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AboutUsText.text = StringsHelper.replace(str: Model.ALL_BULLETINS["ABOUT_US"]!, of: "$split", with: "\n" )
        
        self.ApplyOfSellerText.text = StringsHelper.replace(str: Model.ALL_BULLETINS["APPLY_OF_SELLER"]!,of: "$split", with: "\n" )
        
//        let Version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
//        print(" 当前版本号为：\(Version)")
    }
        
//        AboutUsTitleView.layer.borderWidth = 1.0
//        AboutUsTitleView.layer.borderColor = UIColor.lightGray.cgColor
//
//        BecomeStoreTitleView.layer.borderWidth = 1.0
//        BecomeStoreTitleView.layer.borderColor = UIColor.lightGray.cgColor
//
//        AboutUsText.layer.borderWidth = 1.0
//        AboutUsText.layer.borderColor = UIColor.lightGray.cgColor
//
//        BecomeStoreText.layer.borderWidth = 1.0
//        BecomeStoreText.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//    }



