//
//  FoodDetailInnerOptionTVCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/10.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class FoodDetailInnerOptionTVCell: UITableViewCell {
    
    
    @IBOutlet weak var name: DesignableTextField!
    
    @IBOutlet weak var delete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
