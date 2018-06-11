//
//  UserSettingHelpTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/25.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class UserSettingHelpTVC: UITableViewController {

    @IBOutlet weak var CommonQuestion: UIView!
    @IBOutlet weak var CommonQuestionTwo: UIView!
    @IBOutlet weak var CommonQuestionText: UITextView!
    @IBOutlet weak var CommonQuestionTwoText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommonQuestion.layer.borderWidth = 1.0
        CommonQuestion.layer.borderColor = UIColor.lightGray.cgColor
        
        CommonQuestionTwo.layer.borderWidth = 1.0
        CommonQuestionTwo.layer.borderColor = UIColor.lightGray.cgColor
        
        CommonQuestionText.layer.borderWidth = 1.0
        CommonQuestionText.layer.borderColor = UIColor.lightGray.cgColor
        
        CommonQuestionTwoText.layer.borderWidth = 1.0
        CommonQuestionTwoText.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
