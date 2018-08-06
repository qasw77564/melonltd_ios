//
//  UserSettingMainPageTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingMainPageTVC: UITableViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var accunt: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var version: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        


    }
    override func viewWillAppear(_ animated: Bool) {
        
        let Version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        self.version.text = (" V：\(Version)")
        
//        let account: AccountInfoVo = AccountInfoVo()
        
        
        ApiManager.userFindAccountInfo(ui: self, onSuccess: { account in
            // TODO
            self.accunt.text = account?.account
            self.bonus.text = account?.bonus
            
            
            print(account?.photo)

            let photo: String! = ""
            if photo != nil || photo != "" {
                self.photo.image = UIImage(named: "Logo")
            }else {
                self.photo?.setImage(with: URL(string: (account?.photo!)!), transformer: TransformerHelper.transformer(identifier: (account?.photo!)!))
            }

            self.photo?.clipsToBounds = true
            
           
            
        }) { err_msg in
            // TODO
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
