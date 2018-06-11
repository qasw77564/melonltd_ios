//
//  RegisterUserViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/22.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RegisterUserVC: UIViewController {
    
    @IBOutlet weak var sendTokenToMyPhone: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var validCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        sendTokenToMyPhone.layer.borderWidth = 1
//        sendTokenToMyPhone.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
//        // Do any additional setup after loading the view.
//        self.legalPopView.layer.cornerRadius=10
//        self.legalPopView.frame.size.width = self.view.frame.width*0.8
//        self.legalPopView.frame.size.height = self.view.frame.height*0.8
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var legalPopView: UIView!
    @IBAction func showLegalPopView(_ sender: Any) {
        self.view.addSubview(legalPopView)
        legalPopView.center = self.view.center
    }
    
    @IBAction func goBankRegisterPage(_ sender: Any) {
        self.legalPopView.removeFromSuperview()
    }
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
}
