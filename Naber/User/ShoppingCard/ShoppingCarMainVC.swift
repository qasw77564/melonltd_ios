//
//  ShoppingCarMainViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class MainItemClass{
    var storeName:String = ""
    var totalMoney:String = ""
    var totalBonus:String = ""
    var subItems = [SubItemClass]()
}

class SubItemClass {
    var itemImage:String = ""
    var itemName:String = ""
    var itemMoney:String = ""
    var itemType:String = ""
    var numberLabel = ""
}

extension ShoppingCarMainVC: MainCellDelegate {
    func contentDidChange(cell: ShoppingCarMainTVCell) {
        //self.shoppingCarMainTableView.beginUpdates()
        print("first content change")
        //self.shoppingCarMainTableView.endUpdates()
        
        print("ShoppingCarMainViewController cell.totalSubItem.count",cell.totalSubItem.count)
        print("ShoppingCarMainViewController cell.oldIndexSubFromData",cell.oldIndexSubFromData)
        print("ShoppingCarMainViewController cell.oldIndexFromData",cell.oldIndexFromData)
        
        self.toltalItem[cell.oldIndexSubFromData].subItems = cell.totalSubItem
        
        if cell.totalSubItem.count > 1 {
            self.toltalItem[cell.oldIndexFromData].subItems.remove(at: cell.oldIndexSubFromData)
            self.shoppingCarMainTableView.reloadData()
        }
    }
}


class ShoppingCarMainVC: UIViewController {

    var toltalItem =  [MainItemClass]()
    
    @IBOutlet weak var shoppingCarMainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCarMainTableView.delegate = self
        shoppingCarMainTableView.dataSource = self
        
      
        setupValueForItems()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupValueForItems(){
        
        let firstStore = MainItemClass()
        firstStore.storeName="測試店家"
        firstStore.totalMoney="50"
        firstStore.totalBonus="5";
        //---------------------------------
        let firstStoreItem1 = SubItemClass()
        firstStoreItem1.itemImage = "blackCoffee"
        firstStoreItem1.itemName = "珍珠奶茶"
        firstStoreItem1.itemMoney = "20"
        firstStoreItem1.itemType = "大杯"
        firstStoreItem1.numberLabel = "2"
        firstStore.subItems.append(firstStoreItem1)
        
        let firstStoreItem2 = SubItemClass()
        firstStoreItem2.itemImage = "blackCoffee"
        firstStoreItem2.itemName = "泡沫紅茶"
        firstStoreItem2.itemMoney = "10"
        firstStoreItem2.itemType = "小杯"
        firstStoreItem2.numberLabel = "1"
        firstStore.subItems.append(firstStoreItem2)
        //---------------------------------
        toltalItem.append(firstStore)
        //---------------------------------
        let secondStore = MainItemClass()
        secondStore.storeName="測試2"
        secondStore.totalMoney="40"
        secondStore.totalBonus="4";
        //---------------------------------
        let sccondStoreItem1 = SubItemClass()
        sccondStoreItem1.itemImage = "blackCoffee"
        sccondStoreItem1.itemName = "珍珠奶茶"
        sccondStoreItem1.itemMoney = "20"
        sccondStoreItem1.itemType = "大杯"
        sccondStoreItem1.numberLabel = "2"
        secondStore.subItems.append(sccondStoreItem1)
        
        let sccondStoreItem2 = SubItemClass()
        sccondStoreItem2.itemImage = "blackCoffee"
        sccondStoreItem2.itemName = "芋香奶茶"
        sccondStoreItem2.itemMoney = "20"
        sccondStoreItem2.itemType = "大杯"
        sccondStoreItem2.numberLabel = "2"
        secondStore.subItems.append(sccondStoreItem2)
        
        //---------------------------------
        toltalItem.append(secondStore)
        //---------------------------------
        //print(toltalItem.count)

    }
    

    
    

}

extension ShoppingCarMainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return(CGFloat(toltalItem[indexPath.row].subItems.count * 96 + 104))
    }
//
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return storeName.count
        return toltalItem.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingCarMainTVCell
        cell.storeName.text = toltalItem[indexPath.row].storeName
        cell.totalSubItem = [SubItemClass]()
        print("in Main Table View:",[indexPath.row],",",toltalItem[indexPath.row].subItems.count)
        
        cell.totalSubItem = toltalItem[indexPath.row].subItems
        cell.cancelOrder.tag = indexPath.row
        cell.cancelOrder.addTarget(self, action: #selector(cancelOrderMethod(sender:)), for: .touchUpInside)
        cell.oldIndexFromData = indexPath.row
        cell.mainCellDelegate = self
        cell.itemTable.reloadData()
        //
        //NotificationCenter

        return cell
    }
    
    @objc func myButtonMethod(sender : UIButton!) {
        print("myButtonMethod",sender.tag)
    }

    @objc func cancelOrderMethod(sender : UIButton!) {
        print("cancelOrderMethod",sender.tag)
        
            self.toltalItem.remove(at: sender.tag) // this is the dataSource array of your tableView
            let indexPath = IndexPath(row: sender.tag, section: 0)
            self.shoppingCarMainTableView.beginUpdates()
            self.shoppingCarMainTableView.deleteRows(at: [indexPath], with: .fade)
            self.shoppingCarMainTableView.endUpdates()
            self.shoppingCarMainTableView!.reloadData()
       
    }
    

    
}

