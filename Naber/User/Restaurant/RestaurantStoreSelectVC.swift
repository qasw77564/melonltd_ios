//
//  RestaurantStoreSelectViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/3.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantStoreSelectVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var food: FoodVo!
    var itemVo: FoodItemVo!
    
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    
    @IBAction func numberStepperAction(_ sender: UIStepper) {
        self.orderNumber.text = String(Int(sender.value))
        calculatMoney()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderTotal.text = "0"
        self.orderNumber.text = "1"
        self.numberStepper.maximumValue = 50
        self.numberStepper.minimumValue = 1
        self.numberStepper.value = 1
        
        self.itemVo = FoodItemVo();
        for i in 0..<self.food.food_data.scopes.count {
            if self.food.food_data.scopes[i].price == self.food.default_price {
                if self.itemVo.scopes.isEmpty {
                    self.itemVo.scopes.append(ItemVo.init(name: self.food.food_data.scopes[i].name, price: self.food.food_data.scopes[i].price, tag: i))
                }
            }
            self.food.food_data.scopes[i].tag = i
        }
        
        for i in 0..<self.food.food_data.opts.count {
            self.food.food_data.opts[i].tag = i
        }
        
        for i in 0..<self.food.food_data.demands.count {
            self.itemVo.demands.append(DemandsItemVo.init(name: self.food.food_data.demands[i].name))
            for j in 0..<self.food.food_data.demands[i].datas.count {
                if self.itemVo.demands[i].datas.isEmpty {
                    self.itemVo.demands[i].datas.append(ItemVo.init(name: self.food.food_data.demands[i].datas[j].name, price: self.food.food_data.demands[i].datas[j].price, tag: j))
                }
                self.food.food_data.demands[i].datas[j].tag = j
            }
        }
        self.calculatMoney()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RestaurantStoreSelectVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return self.food.food_data.scopes.count
        case 1:
            return self.food.food_data.opts.count
        case 2...:
            return self.food.food_data.demands[section - 2].datas.count
        default:
            return 0
        }
    }
    
    // 計算 Sections Cell 數量給 tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.food.food_data.demands.count + 2
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! RestaurantStoreSelectTCCellHead
        switch (section) {
        case 0:
            cell.name.text = "規格(必選)"
        case 1:
            cell.name.text = "追加項目";
        case 2...:
            cell.name.text = self.food.food_data.demands[section - 2].name
        default:
            cell.name.text = ""
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footerCell = tableView.dequeueReusableCell(withIdentifier: "Footer") as! RestaurantStoreSelectTVCellFoot
        return footerCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    // 改寫初始資料給每個cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c = cell as? RestaurantStoreSelectTVCell {
            switch (indexPath.section) {
            case 0:
                c.item = self.food.food_data.scopes[indexPath.row]
                c.tag = indexPath.row
            case 1:
                c.item = self.food.food_data.opts[indexPath.row]
                c.tag = indexPath.row
            case 2...:
                c.item = self.food.food_data.demands[indexPath.section - 2].datas[indexPath.row]
                c.tag = indexPath.row
            default:
                break
            }
            c.cellWillAppear()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantStoreSelectTVCell
        
        switch (indexPath.section) {
        case 0:
            cell.radioButton.isSelected = self.itemVo.scopes[0].equal(item: self.food.food_data.scopes[indexPath.row])
            cell.tag = indexPath.row
        case 1:
            cell.tag = indexPath.row
            cell.radioButton.isSelected = self.itemVo.opts.contains { opt -> Bool in
                return opt.equal(item: self.food.food_data.opts[indexPath.row])
            }
        case 2...:
            cell.radioButton.isSelected = self.itemVo.demands[indexPath.section - 2].datas[0].equal(item: self.food.food_data.demands[indexPath.section - 2].datas[indexPath.row])
            cell.tag = indexPath.row
        default:
            break
        }
        cell.triggerRadioStatus(cell.radioButton.isSelected)
       
        return cell
    }
    
    // 點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell : RestaurantStoreSelectTVCell = (tableView.cellForRow(at: indexPath) as? RestaurantStoreSelectTVCell)!
        switch (indexPath.section) {
        case 0: // 必選 單選 規格
            self.itemVo.scopes.removeAll()
            self.itemVo.scopes.append(cell.item)
        case 1: // 多選 追加項目
            var index: Int!
            for i in 0..<self.itemVo.opts.count {
                if self.itemVo.opts[i].equal(item: cell.item) {
                    index = i
                }
            }
            if index != nil {
                self.itemVo.opts.remove(at: index)
            }else {
                self.itemVo.opts.append(cell.item)
            }
        case 2...: // 必選多需求
            self.itemVo.demands[indexPath.section - 2].datas.removeAll()
            self.itemVo.demands[indexPath.section - 2].datas.append(cell.item)
        default:
            break
        
        }
        self.calculatMoney()
        tableView.reloadData()

    }
    
    func calculatMoney(){
        let orderNumber = self.orderNumber.text
        let number:Int = Int (orderNumber!)!
        
        var selectMoney: Int = 0
        for scopes in self.itemVo.scopes {
            selectMoney += Int(scopes.price)!
        }
        for opt in self.itemVo.opts {
            selectMoney += Int(opt.price)!
        }
        
        selectMoney = selectMoney * number
        
        self.itemVo.opts.forEach { opt in
            print(opt.name + "::" + opt.price)
        }
        self.orderTotal.text = String(selectMoney)
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        let screenSize: CGRect = UIScreen.main.bounds
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x:0, y:0, width:screenSize.width , height:thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:frame.size.height - thickness, width:frame.size.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width:thickness, height:frame.size.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:frame.size.width - thickness, y:0, width:thickness, height:frame.size.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
    }
    
}
