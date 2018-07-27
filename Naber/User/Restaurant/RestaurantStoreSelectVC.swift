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
    
    var foodItemVo: FoodItemVo! = FoodItemVo()
    var food: FoodVo!
    
    var tmpFoodItemVo: FoodItemVo! = FoodItemVo()
//    var selectMenu = SelectMenuClass()
    
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var numberStepper: UIStepper!
    
    @IBAction func numberStepperAction(_ sender: UIStepper) {
        self.orderNumber.text = String(Int(sender.value))
        calculatMoney()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
//        setupValue ()
//        orderTotal.text = "0"
//        orderNumber.text = "1"
        numberStepper.maximumValue = 50
        numberStepper.minimumValue = 1
//        selectMenuTable.delegate = self
//        selectMenuTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let uuid: String = self.food.food_uuid
        ApiManager.restaurantFoodDetail(uuid: uuid, ui: self, onSuccess: { food in
            food?.food_data.opts.forEach{ opt in
                print(opt.name + " : " + opt.price)
            }
//            self.food = food
//            food?.food_data.food_uuid = food?.food_uuid
//            food?.food_data.food_name = food?.food_name
//            food?.food_data.price = food?.default_price
//            food?.food_data.food_photo = food?.photo
//            print(food)
            self.foodItemVo = food?.food_data
            self.tableView.reloadData()
            
        }) { err_msg in
            print(err_msg)
        }
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
            print("scopes.count : " + String(self.foodItemVo.scopes.count))
            return self.foodItemVo.scopes.count
        case 1:
            print("opts.count : " + String(self.foodItemVo.opts.count))
            return self.foodItemVo.opts.count
        case 2...:
            return self.foodItemVo.demands[section - 2].datas.count
        default:
            return 0
        }
    }
    
    // 計算 Sections Cell 數量給 tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.foodItemVo.demands.count + 2
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
            cell.name.text = self.foodItemVo.demands[section-2].name
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantStoreSelectTVCell
        
        switch (indexPath.section) {
        case 0:
            cell.name?.text = self.foodItemVo.scopes[indexPath.row].name
            cell.price?.text = self.foodItemVo.scopes[indexPath.row].price
            cell.tag = indexPath.row
            print(cell.isSelected)
//            if selectMenu.scopes[indexPath.row].isSelected {
//                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
//            }else{
//                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
//            }
//            cell.selectedRadio(cell.radioButton)
        case 1:
            cell.name?.text = self.foodItemVo.opts[indexPath.row].name
            cell.price?.text = self.foodItemVo.opts[indexPath.row].price
            cell.tag = indexPath.row
            print(cell.isSelected)
//            cell.selectedRadio(cell.radioButton)
//            if selectMenu.options[indexPath.row].isSelected {
//                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
//            }else{
//                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
//            }

        case 2...:
            cell.name?.text = self.foodItemVo.demands[indexPath.section - 2].datas[indexPath.row]?.name
            cell.price?.text = ""
            cell.tag = indexPath.row
            print(cell.isSelected)
//            if selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected {
//                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
//            }else{
//                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
//            }
//            cell.selectedRadio(cell.radioButton)
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell : RestaurantStoreSelectTVCell = (tableView.cellForRow(at: indexPath) as? RestaurantStoreSelectTVCell)!
        switch (indexPath.section) {
        case 0: // 必選 單選 規格
            print(tableView.cellForRow(at: indexPath)?.tag ?? "tab nil")
            self.tmpFoodItemVo.scopes.removeAll()
            self.tmpFoodItemVo.scopes.append(self.foodItemVo.scopes[indexPath.row])
        case 1: // 多選 追加項目
             print(tableView.cellForRow(at: indexPath)?.tag ?? "tab nil")
            self.tmpFoodItemVo.opts.append(self.foodItemVo.opts[indexPath.row])
            cell.triggerRadioStatus()
        case 2...: // 必選多需求
            print(indexPath.section - 2)
            print(tableView.cellForRow(at: indexPath)?.tag ?? "tab nil")
            if self.tmpFoodItemVo.demands.isEmpty {
                self.tmpFoodItemVo.demands.append(DemandsItemVo())
            }
            
//            print(self.tmpFoodItemVo.demands[indexPath.section - 2].datas[indexPath.row] ?? "")
//            self.foodItemVo.demands[indexPath.section - 2].datas
//            for tempRow in selectMenu.demands[indexPath.section-2].subs {
//                tempRow.isSelected = false
//            }
//
//            if selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected {
//                selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected = false
//            }else{
//                selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected = true
//            }
//            tableView.reloadData()

        default:
            break
        
        }
        
//        if let cell: RestaurantStoreSelectTVCell = tableView.cellForRow(at: indexPath) as? RestaurantStoreSelectTVCell {
//            cell.triggerRadioStatus()
//            print("get cell ")
//            print(cell)
//        }
//          tableView.reloadData()
        calculatMoney()
        
    }
    
    func calculatMoney(){
        let orderNumber = self.orderNumber.text
        let number:Int = Int (orderNumber!)!
        
        var selectMoney:Int = 0
        for scopes in self.foodItemVo.scopes {
            selectMoney += Int(scopes.price)!
//            if tempRow.isSelected {
//                let selectPrice:Int = Int(tempRow.money)!
//                selectMoney+=selectPrice
//            }
            
        }
        for opt in self.foodItemVo.opts {
//            if tempRow.isSelected {
//                let selectPrice:Int = Int(tempRow.money)!
//                selectMoney+=selectPrice
//            }
            selectMoney += Int(opt.price)!

        }
        selectMoney = selectMoney * number
        print("selectMoney:" ,selectMoney)
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
