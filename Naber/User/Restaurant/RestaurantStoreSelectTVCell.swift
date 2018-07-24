//
//  RestaurantStoreSelectScopresTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/3.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantStoreSelectTVCell: UITableViewCell {

    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var radioButton: UIButton!
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 8
            newFrame.size.width -= 16
            super.frame = newFrame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let color: UIColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1)
        self.contentView.layer.addBorder(edge: UIRectEdge.left, color: color, thickness: 0.5)
        self.contentView.layer.addBorder(edge: UIRectEdge.right, color: color, thickness: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
