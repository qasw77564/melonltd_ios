//
//  RegisterStoreViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/23.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RegisterStoreVC: UIViewController {
    @IBOutlet weak var restroomName: UITextField!
    @IBOutlet weak var restroomAddress: UITextField!
    @IBOutlet weak var contactPersonName: UITextField!
    @IBOutlet weak var contactPhone: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sendToSeverForRegisterStore(_ sender: Any) {
        //TODO:ASK SERVER
        let alert = UIAlertController(title: "", message: "確定要送出嗎？",   preferredStyle: .alert)
        let actionTaken = UIAlertAction(title: "確認", style: .default) { (hand) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyBoard.instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
            self.present(destinationVC!, animated: false, completion: nil)
        }
        alert.addAction(actionTaken)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alert, animated: false) {}
        
    }
    


}
