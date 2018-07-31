//
//  ShoppingCarMainTableViewCell.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class ShoppingCarMainTVCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    // 依照商家所加入的品項列表
    // Model.USER_CACHE_SHOPPING_CART[self.tag].orders

    

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var itemTable: UITableView! {
        didSet {
            self.itemTable.delegate = self
            self.itemTable.dataSource = self
        }
    }
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cancelOrder: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.price.text = "0"
        self.bonus.text = "0"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        var price: Int = 0
        for i in 0..<Model.USER_CACHE_SHOPPING_CART[self.tag].orders.count {
            price += Int(Model.USER_CACHE_SHOPPING_CART[self.tag].orders[i].item.price)!
        }
        self.price.text = price.description
        self.bonus.text = (price / 10).description
    }
    
    func cellWillAppear (){
        var price: Int = 0
        for i in 0..<Model.USER_CACHE_SHOPPING_CART[self.tag].orders.count {
            price += Int(Model.USER_CACHE_SHOPPING_CART[self.tag].orders[i].item.price)!
        }
        self.price.text = price.description
        self.bonus.text = (price / 10).description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(totalSubItem.count)
        return Model.USER_CACHE_SHOPPING_CART[self.tag].orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingCardSubTVCell
        
        cell.foodName.text = Model.USER_CACHE_SHOPPING_CART[self.tag].orders[indexPath.row].item.food_name
        
        cell.foodPhoto.image = UIImage(named: "Logo")
        cell.foodCount.text = Model.USER_CACHE_SHOPPING_CART[self.tag].orders[indexPath.row].count
        cell.foodPrice.text = Model.USER_CACHE_SHOPPING_CART[self.tag].orders[indexPath.row].item.price
        cell.countStepper.tag = indexPath.row
        cell.countStepper.value = Double(Model.USER_CACHE_SHOPPING_CART[self.tag].orders[indexPath.row].count)!
        cell.countStepper.addTarget(self, action: #selector(changedCount), for: .touchUpInside)

        cell.deleteFoodBtn.tag = indexPath.row
        cell.deleteFoodBtn.addTarget(self, action: #selector(deleteFoodByIndex), for: .touchUpInside)
        return cell
    }
    
    @objc func changedCount(_ sender: UIStepper) {
        let price: Int = Int(Int(Model.USER_CACHE_SHOPPING_CART[self.tag].orders[sender.tag].item.price)! /
        Int(Model.USER_CACHE_SHOPPING_CART[self.tag].orders[sender.tag].count)!)
        Model.USER_CACHE_SHOPPING_CART[self.tag].orders[sender.tag].count = Int(sender.value).description
        Model.USER_CACHE_SHOPPING_CART[self.tag].orders[sender.tag].item.price = Int(price * Int(sender.value)).description
    }
    
    @objc func deleteFoodByIndex(sender : UIButton!) {
        print(sender.tag)
       Model.USER_CACHE_SHOPPING_CART[self.tag].orders.remove(at: sender.tag)
    }
    
    func calculate (){

    }

}


