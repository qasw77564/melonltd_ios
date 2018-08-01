//
//  SearchMainTVCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/8.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class SearchMainTVCell: UITableViewCell {

    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var itemNumberAndStatus: UILabel!
    @IBOutlet weak var itemList: UILabel!
    @IBOutlet weak var memoList: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
