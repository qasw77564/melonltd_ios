//
//  ShoppingCarMainTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


protocol MainCellDelegate: class {
    func contentDidChange(cell: ShoppingCarMainTVCell)
}

class ShoppingCarMainTVCell: UITableViewCell{

    var oldIndexFromData = 0;
    var oldIndexSubFromData=0;
    
    weak var mainCellDelegate: MainCellDelegate?

    
    var totalSubItem =  [SubItemClass]()

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var itemTable: UITableView!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var totalBonus: UILabel!
    @IBOutlet weak var submitOrder: UIButton!
    @IBOutlet weak var cancelOrder: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.itemTable.delegate = self
        self.itemTable.dataSource = self
        self.itemTable.estimatedRowHeight = 44
        self.itemTable.rowHeight = UITableViewAutomaticDimension
        
        self.totalMoney.text = "0"
        self.totalBonus.text = "0"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension ShoppingCarMainTVCell: SubCellDelegate {
    func contentDidChange(cell: ShoppingCardSubTVCell) {
        totalSubItem[cell.oldDateIndex].numberLabel = cell.numberLabel.text!
        //self.itemTable.beginUpdates()
        print("second content changed")
        self.oldIndexSubFromData = cell.oldDateIndex
        //self.itemTable.endUpdates()
        print("totalSubItem.count", totalSubItem.count)
        print("in ShoppingCarMainTableViewCell, totalSubItem.count",totalSubItem.count)
        if totalSubItem.count > 1 {
            mainCellDelegate?.contentDidChange(cell: self)
        }
    }
}

extension ShoppingCarMainTVCell: UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(totalSubItem.count)
        return totalSubItem.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingCardSubTVCell
        
        cell.oldDateIndex = indexPath.row
        
        cell.itemImage.image = UIImage(named: totalSubItem[indexPath.row].itemImage)
        cell.itemName.text = totalSubItem[indexPath.row].itemName
        cell.itemMoney.text = totalSubItem[indexPath.row].itemMoney
        cell.itemType.text = totalSubItem[indexPath.row].itemType
        cell.numberLabel.text = totalSubItem[indexPath.row].numberLabel
        cell.numberPicker.value = Double(totalSubItem[indexPath.row].numberLabel)!
        cell.trashCanImageView.tag = indexPath.row
        cell.numberPicker.tag = indexPath.row
        cell.numberPicker.addTarget(self, action: #selector(stepperAction(sender:)), for: .valueChanged)
        cell.trashCanImageView.addTarget(self, action: #selector(deleteCellItem(sender:)), for: .touchUpInside)
        
        var oldMoney = (self.totalMoney.text! as NSString).doubleValue
        
        let itemMoney = (totalSubItem[indexPath.row].itemMoney as NSString).doubleValue
        let itemNumber = (totalSubItem[indexPath.row].numberLabel as NSString).doubleValue
        oldMoney += itemMoney*itemNumber
        var totalBounus:Double = 0
        totalBounus = oldMoney * 0.1
        let totalPayInt = Int(oldMoney)
        let totalBounusInt = Int(totalBounus)
        self.totalMoney.text = String(totalPayInt)
        self.totalBonus.text = String(totalBounusInt)
        
        cell.delegate = self
        
        return cell
    }

    @objc func deleteCellItem(sender : UIButton!) {
        //print(sender.tag)
        
        print("totalSubItem.count",totalSubItem.count)
        
        if totalSubItem.count > 1  {
            self.totalSubItem.remove(at: sender.tag) // this is the dataSource array of your tableView
            let indexPath = IndexPath(row: sender.tag, section: 0)
            self.itemTable.beginUpdates()
            self.itemTable.deleteRows(at: [indexPath], with: .fade)
            self.itemTable.endUpdates()
            self.itemTable!.reloadData()
            calculateMoney()
            oldIndexSubFromData = sender.tag
            
        }
        print("totalSubItem.count",totalSubItem.count)
        print("numberOfrow",self.itemTable.numberOfRows(inSection: 0))

    }
    
    @objc func stepperAction(sender: UIStepper)  {
        //print("Stepper \(sender.tag) clicked. Its value \(sender.value)")
        calculateMoney()
    }
    
    func calculateMoney (){
        let totalRow = self.itemTable.numberOfRows(inSection: 0)
        var totalPay:Double = 0
        var totalBounus:Double = 0
        for index in 0...totalRow-1 {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = self.itemTable.cellForRow(at: indexPath) as! ShoppingCardSubTVCell
            totalSubItem[indexPath.row].numberLabel = cell.numberLabel.text!
            totalPay += Double(totalSubItem[index].itemMoney)! * Double(cell.numberPicker.value)
        }
        totalBounus = totalPay * 0.1
        let totalPayInt = Int(totalPay)
        let totalBounusInt = Int(totalBounus)
        self.totalMoney.text = String(totalPayInt)
        self.totalBonus.text = String(totalBounusInt)
        
    }
    
}

