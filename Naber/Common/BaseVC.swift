//
//  CommonVC.swift
//  Naber
//
//  Created by 王淳彦 on 2018/7/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
//import CoreLocation


class BaseVC: UIViewController{
    let USER_TYPES: [Identity] = Identity.getUserValues()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // 判斷是否登入過無超過兩週，並判斷上次登入的帳號類別
    override func viewDidAppear(_ animated: Bool) {
        
//        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
//            self.present(vc, animated: false, completion: nil)
//        }
        let now: Int = Int(Date().timeIntervalSince1970 * 1000)
        if now - NaberConstant.REMEMBER_DAY < UserSstorage.getLoginTime() {
            let account: AccountInfoVo? = UserSstorage.getAccount()
            if USER_TYPES.contains(Identity(rawValue: (account?.identity)!)!) {
//                BaseVC.getBulletin(ui: self)
                // 已登入使用者
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserPage") as? UserPageUITabBarController {
                    present(vc, animated: false, completion: nil)
                }
            } else if Identity.SELLERS == Identity(rawValue: (account?.identity)!)! {
                // 已登入過商家
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StorePage") as? StorePageUITabBarController {
                    self.present(vc, animated: false, completion: nil)
                }
            } else {
                UserSstorage.clearUserData()
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                    self.present(vc, animated: false, completion: nil)
                }
            }
        } else {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginHomeRoot") as? LoginHomeRootUINC {
                self.present(vc, animated: false, completion: nil)
            }
        }
    }

    
    
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // 印出目前所在位置座標
//        let currentLocation :CLLocation = locations[0] as CLLocation
//        print("\(currentLocation.coordinate.latitude)")
//        print(", \(currentLocation.coordinate.longitude)")
//    }
    
//    public static func getBulletin (ui: UIViewController){
//        ApiManager.bulletin(ui: ui, onSuccess: { bulletins in
//            Model.ALL_BULLETINS.removeAll()
//            bulletins.forEach({ b in
//                Model.ALL_BULLETINS[(b?.bulletin_category)!] = b?.content_text
//            })
//            print(Model.ALL_BULLETINS)
//        }) { err_msg in
//            print(err_msg)
//        }
//    }
//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
