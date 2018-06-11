//
//  ShoppingCardSubTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

protocol SubCellDelegate: class {
    func contentDidChange(cell: ShoppingCardSubTVCell)
}

class ShoppingCardSubTVCell: UITableViewCell {
    
    var oldDateIndex = 0;
    
    
    @IBOutlet weak var itemImage: UIImageView!

    @IBOutlet weak var itemName: UILabel!

    @IBOutlet weak var itemType: UILabel!
    
    @IBOutlet weak var itemMoney: UILabel!

    @IBOutlet weak var numberLabel: UILabel!

    @IBOutlet weak var numberPicker: UIStepper!

    @IBOutlet weak var trashCanImageView: UIButton!
    

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberLabel.text = Int(sender.value).description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberPicker.maximumValue = 50
        numberPicker.minimumValue = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var delegate: SubCellDelegate?
    
    @IBAction func buttonMoreTouched(_ sender: UIButton) {
        //labelDescription.text = longText
        delegate?.contentDidChange(cell: self)
    }
    
    @IBAction func buttonLessTouched(_ sender: UIButton) {
        //labelDescription.text = shortText
        print("buttonLessTouched")
        delegate?.contentDidChange(cell: self)
    }
    
    


}
