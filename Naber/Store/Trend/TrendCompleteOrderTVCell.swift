//
//  TrendCompleteOrderTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/6.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class TrendCompleteOrderTVCell: UITableViewCell {


    @IBOutlet weak var orderStatus: UIButton!
    
    @IBOutlet weak var orderMoney: UILabel!
    
    @IBOutlet weak var buyerPhone: UILabel!
    
    @IBOutlet weak var buyerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
