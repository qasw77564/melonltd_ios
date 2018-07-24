//
//  RestaurantStoreSelectViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/3.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class SelectMenuClass{
    var scopes   = [SelectMenuScope]()
    var demands = [SelectMenuDemand]()
    var options  = [SelectMenuOption]()
}
class SelectMenuScope{
    var name:String = ""
    var money:String = ""
    var isSelected:Bool = false
    init (name:String,money:String){
        self.name = name
        self.money = money
    }
}
class SelectMenuDemand{
    var name : String = ""
    var subs = [SelectMenuSubDemand]()
}
class SelectMenuSubDemand{
    var name:String = ""
    var isSelected:Bool = false
    init (name:String){
        self.name = name
    }
}
class SelectMenuOption{
    var name:String = ""
    var money:String = ""
    var isSelected:Bool = false
    
    init (name:String,money:String){
        self.name = name
        self.money = money
    }
}


class RestaurantStoreSelectVC: UIViewController {
    
    @IBOutlet weak var selectMenuTable: UITableView!
    
    var selectMenu = SelectMenuClass()
    
    @IBOutlet weak var orderTotal: UILabel!
    
    @IBOutlet weak var orderNumber: UILabel!
    
    @IBOutlet weak var numberStepper: UIStepper!
    
    @IBAction func numberStepperAction(_ sender: UIStepper) {
        self.orderNumber.text = String(Int(sender.value))
        calculatMoney()
    }
    
    func setupValue () {
        let scope1 = SelectMenuScope(name:"大杯",money:"50")
        let scope2 = SelectMenuScope(name:"中杯",money:"40")
        let scope3 = SelectMenuScope(name:"小杯",money:"30")
        selectMenu.scopes.append(scope1)
        selectMenu.scopes.append(scope2)
        selectMenu.scopes.append(scope3)
        
        let demand1 = SelectMenuDemand()
        demand1.name = "甜度"
        let subDemand1 = SelectMenuSubDemand(name:"全糖")
        let subDemand2 = SelectMenuSubDemand(name:"8分糖")
        let subDemand3 = SelectMenuSubDemand(name:"半糖")
        let subDemand4 = SelectMenuSubDemand(name:"3分糖")
        let subDemand5 = SelectMenuSubDemand(name:"無糖")
        
        demand1.subs.append(subDemand1)
        demand1.subs.append(subDemand2)
        demand1.subs.append(subDemand3)
        demand1.subs.append(subDemand4)
        demand1.subs.append(subDemand5)

        selectMenu.demands.append(demand1)
        
        let demand2 = SelectMenuDemand()
        demand2.name = "冰塊"
        let subDemand1st = SelectMenuSubDemand(name:"多冰")
        let subDemand2nd = SelectMenuSubDemand(name:"正常冰")
        let subDemand3rd = SelectMenuSubDemand(name:"少冰")
        let subDemand4th = SelectMenuSubDemand(name:"碎冰")
        let subDemand5th = SelectMenuSubDemand(name:"去冰")
        let subDemand6th = SelectMenuSubDemand(name:"無冰")

        demand2.subs.append(subDemand1st)
        demand2.subs.append(subDemand2nd)
        demand2.subs.append(subDemand3rd)
        demand2.subs.append(subDemand4th)
        demand2.subs.append(subDemand5th)
        demand2.subs.append(subDemand6th)

        selectMenu.demands.append(demand2)

        let option1 = SelectMenuOption(name:"珍珠",money:"10")
        let option2 = SelectMenuOption(name:"芉圓",money:"10")
        let option3 = SelectMenuOption(name:"粉圓",money:"10")

        selectMenu.options.append(option1)
        selectMenu.options.append(option2)
        selectMenu.options.append(option3)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupValue ()
        orderTotal.text = "0"
        orderNumber.text = "1"
        numberStepper.maximumValue = 50
        numberStepper.minimumValue = 1
        selectMenuTable.delegate=self
        selectMenuTable.dataSource=self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RestaurantStoreSelectVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0;
        switch (section) {
        case 0:
            rowNum = selectMenu.scopes.count
        case 1:
            rowNum = selectMenu.options.count
        case 2...99:
            rowNum = selectMenu.demands[section-2].subs.count
        default:
            rowNum = 0
        }
        return rowNum
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let scopeCount = 1
        let option = 1
        let demandCount = selectMenu.demands.count
        let sectionNumber = scopeCount + option + demandCount
        return sectionNumber
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "Header") as! RestaurantStoreSelectTCCellHead

        switch (section) {
        case 0:
            headerCell.name.text = "規格必選"
        //return sectionHeaderView
        case 1:
            headerCell.name.text = "追加項目";
        //return sectionHeaderView
        case 2...99:
            headerCell.name.text = selectMenu.demands[section-2].name
        //return sectionHeaderView
        default:
            headerCell.name.text = ""
        }
        
        return headerCell
    }
    
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 30
    //    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footerCell = tableView.dequeueReusableCell(withIdentifier: "Footer") as! RestaurantStoreSelectTVCellFoot
        return footerCell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantStoreSelectTVCell
        
        switch (indexPath.section) {
        case 0:
            cell.name?.text = selectMenu.scopes[indexPath.row].name
            cell.money?.text = selectMenu.scopes[indexPath.row].money
            if selectMenu.scopes[indexPath.row].isSelected {
                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
            }else{
                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
            }
        case 1:
            cell.name?.text = selectMenu.options[indexPath.row].name
            cell.money?.text = selectMenu.options[indexPath.row].money
            if selectMenu.options[indexPath.row].isSelected {
                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
            }else{
                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
            }

        case 2...99:
            cell.name?.text = selectMenu.demands[indexPath.section-2].subs[indexPath.row].name
            cell.money?.text = ""
            
            if selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected {
                cell.radioButton.setImage(UIImage(named: "radioSelect"), for: .normal)
            }else{
                cell.radioButton.setImage(UIImage(named: "radioNoSelect"), for: .normal)
            }

        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        switch (indexPath.section) {
        case 0:
            
            for tempRow in selectMenu.scopes {
                tempRow.isSelected = false
            }
            selectMenu.scopes[indexPath.row].isSelected = true
            tableView.reloadData()
        case 1:
            if selectMenu.options[indexPath.row].isSelected {
                selectMenu.options[indexPath.row].isSelected = false
            }else{
                selectMenu.options[indexPath.row].isSelected = true
            }
            tableView.reloadData()

        case 2...99:
            
            for tempRow in selectMenu.demands[indexPath.section-2].subs {
                tempRow.isSelected = false
            }
            
            if selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected {
                selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected = false
            }else{
                selectMenu.demands[indexPath.section-2].subs[indexPath.row].isSelected = true
            }
            tableView.reloadData()

        default:
            break
        }
        
        calculatMoney()
        
    }
    
    func calculatMoney(){
        let orderNumber = self.orderNumber.text
        let number:Int = Int (orderNumber!)!
        
        var selectMoney:Int = 0
        for tempRow in selectMenu.scopes {
            if tempRow.isSelected {
                let selectPrice:Int = Int(tempRow.money)!
                selectMoney+=selectPrice
            }
            
        }
        for tempRow in selectMenu.options {
            if tempRow.isSelected {
                let selectPrice:Int = Int(tempRow.money)!
                selectMoney+=selectPrice
            }
            
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
