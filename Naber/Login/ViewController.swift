//
//  ViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var account_text: UITextField!
    
    @IBOutlet weak var password_text: UITextField!
    
    @IBOutlet weak var register_button: UIButton!
    
    @IBOutlet weak var store_register_button: UIButton!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    
    @IBOutlet weak var rememberMeImage: UIButton!
    
    
    
    @IBAction func rememberMeSwithOnImage(_ sender: Any) {
        
        
        
        
        
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func rememberMeSwitch(_ sender: Any) {
        if (rememberMeImage.currentImage?.isEqual(UIImage(named: "cbSelect")))! {
            let image = UIImage(named: "cbNoSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }else{
            let image = UIImage(named: "cbSelect") as UIImage?
            rememberMeImage.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func goToNextPage(_ sender: Any) {
        print("Account Text:" + account_text.text! as Any);
        print("Password Text:" + password_text.text! as Any);
       
        switch account_text.text {
        case "1":
            // Safe Present
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController
            {
                present(vc, animated: false, completion: nil)
            }
        case "2":
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController
            {
                present(vc, animated: false, completion: nil)
            }
        case "3":
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tutorial") as? TutorialVC
            {
                present(vc, animated: false, completion: nil)
            }
        default:
            print("Stop running")
        }
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print("device token : " + deviceID)
        
//        register_button.layer.borderWidth = 1
//        register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
//        
//        store_register_button.layer.borderWidth = 1
//        store_register_button.layer.borderColor = (UIColor( red: 243/255, green: 228/255, blue:79/255, alpha: 1.0 )).cgColor
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 鍵盤點擊背景縮放
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//extension ViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//}

