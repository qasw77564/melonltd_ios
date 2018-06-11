//
//  FoodClassTVCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/9.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class FoodClassTVCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var money: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var delete: UIButton!
    
    @IBOutlet weak var editor: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
