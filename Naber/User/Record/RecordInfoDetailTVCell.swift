//
//  RecordInfoTableCellTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RecordInfoDetailTVCell: UITableViewCell {
    
    @IBOutlet var storeName: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var recordTime: UILabel!
    @IBOutlet var totalPayment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
