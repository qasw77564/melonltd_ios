//
//  FoodSubCell.swift
//  Naber
//
//  Created by 王淳彦 on 2018/8/7.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class FoodSubCell : UITableViewCell {
    
    @IBOutlet weak var name: UITextField! {
        didSet{
            self.name.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        }
    }
    @IBOutlet weak var price: UITextField!{
        didSet{
            self.price.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        }
    }
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
