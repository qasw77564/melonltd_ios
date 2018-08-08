//
//  UserSettingAccountDetailTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/24.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class UserSettingAccountDetailTVC: UITableViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var identity: UILabel!
//    var accountinfo: AccountInfoVo = AccountInfoVo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        image.layer.borderWidth = 0
//        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.black.cgColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true

    }
    @IBAction func changePhoto(_ sender: UIButton) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        let alert = UIAlertController.init(title: Optional.none , message: Optional.none , preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "相機", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
                if status == .denied || status == .restricted {
                    self.showAlert(withTitle: "相機權限已關閉", andMessage: "如要變更權限，請至 設定 > 隱私權 > 相機服務 開啟")
                }else {
                    picker.sourceType = .camera
                    picker.allowsEditing = true
                    self.present(picker, animated: true, completion: nil)
                }
            } else {
                self.showAlert(withTitle: "沒有相機設備", andMessage: "You can't take photo, there is no camera.")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "相簿", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
                if status == .denied || status == .restricted {
                    self.showAlert(withTitle: "相簿權限已關閉", andMessage: "如要變更權限，請至 設定 > 隱私權 > 相簿服務 開啟")
                }else {
                    picker.sourceType = .photoLibrary
                    self.present(picker, animated: true, completion: nil)
                }
            }else {
                self.showAlert(withTitle: "沒有相簿功能", andMessage: "You can't take photo, there is no camera.")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "我知道了", style: .default))
        self.present(alert, animated: true)
    }

    // 接到相機 ＆ 相簿回傳的data
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage: UIImage = ImageHelper.resizeImage(originalImage: originalImage, minLenDP: 100)

        ImageHelper.upLoadImage(data: UIImageJPEGRepresentation(resizedImage, 1.0)!, sourcePath: NaberConstant.STORAGE_PATH_USER, fileName: (UserSstorage.getAccount()?.account_uuid)! + ".jpg", onGetUrl: { url in
            let reqData: ReqData = ReqData()
            reqData.uuid = UserSstorage.getAccount()?.account_uuid
            reqData.date = url.absoluteString
            reqData.type = "USER"
            ApiManager.uploadPhoto(req: reqData, ui: self, onSuccess: { urlString in
                self.photo.setImage(with: URL(string: url.absoluteString), transformer: TransformerHelper.transformer(identifier: url.absoluteString))
            }, onFail: { err_msg in
                print(err_msg)
            })
        }) { err_msg in
            print(err_msg)
        }

        self.dismiss(animated: true, completion: nil)
    

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
