//
//  ForgotPasswordViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/22.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func sendToServerForAskPassword(_ sender: Any) {
        
        //TODO:ASK SERVER

        let alert = UIAlertController(title: "", message: "已發送至你的信箱",   preferredStyle: .alert)
        let actionTaken = UIAlertAction(title: "我知道了", style: .default) { (hand) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyBoard.instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC
            self.present(destinationVC!, animated: false, completion: nil)
            
        }
        alert.addAction(actionTaken)
        self.present(alert, animated: false) {}
        
    }


}
