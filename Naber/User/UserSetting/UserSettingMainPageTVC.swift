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
        
        
        let photo: String! = ""
        
        
        if photo == nil || photo == "" {
            self.photo.image = UIImage(named: "Logo")
        }else {
            //            self.photo.setImage(with: URL(string: "http://sdsdsdsdsd.png"), transformer: TransformerHelper.transformer(identifier: "http://sdsdsdsdsd.png"))
            
            self.photo.setImage(with: URL(string: photo), transformer: TransformerHelper.transformer(identifier: photo))
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
