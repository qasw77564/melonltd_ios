//
//  UserSettingAccountDetailTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingAccountDetailTVC: UITableViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var identity: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        image.layer.borderWidth = 0
//        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.black.cgColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true

    }
    @IBAction func changePhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "重設成功！" , preferredStyle: .alert)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        ApiManager.userFindAccountInfo(ui: self, onSuccess: { (account) in
            self.name.text = account?.name
            self.phone.text = account?.phone
            self.email.text = account?.email
            self.birthday.text = account?.birth_day
            self.bonus.text = account?.bonus
            self.identity.text = account?.identity
            let photo: String! = ""
            
            if photo == nil || photo == "" {
                self.photo.image = UIImage(named: "白底黃閃電")
                
            }else {
                self.photo?.setImage(with: URL(string: (account?.photo)!), transformer: TransformerHelper.transformer(identifier: (account?.photo)!))
            }
            self.photo?.clipsToBounds = true
            
        }) { (err_msg) in
            
        }
        
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
