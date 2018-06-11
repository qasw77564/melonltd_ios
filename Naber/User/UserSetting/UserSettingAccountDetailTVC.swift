//
//  UserSettingAccountDetailTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingAccountDetailTVC: UITableViewController {
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        image.layer.borderWidth = 0
//        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.black.cgColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBackHomePage(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
        {
            present(vc, animated: false, completion: nil)
        }
    }
   
}
