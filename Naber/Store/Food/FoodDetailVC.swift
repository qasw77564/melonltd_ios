//
//  FoodDetailVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/9.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class FoodType {
    var name:String = ""
    var money:String = ""
    
}

class FoodExtra {
    var name:String = ""
    var money:String = ""
    
}

class FoodOptions {
    var name:String = ""
    var options = [FoodOption]()
}

class FoodOption {
    var name:String = ""
}

extension FoodDetailVC : OutterOptionDelegate{
    func addInnerCell(cell: FoodDetailOutterOptionTVCell) {
        print("Outter Option is" , cell.outterTableIndex)
        self.foodOptions[cell.outterTableIndex].options = cell.innerOption
        print("New Food Option count: " ,  self.foodOptions[cell.outterTableIndex].options.count)
        self.outterOptionsTable.reloadData()
        self.reculculateOutTableHeight()
    }
    

}

class FoodDetailVC: UIViewController {
    
    var foodTypes = [FoodType]()
    var foodExtras = [FoodExtra]()
    var foodOptions = [FoodOptions]()
    
    @IBOutlet weak var typeTable: UITableView!
    @IBOutlet weak var extraTable: UITableView!
    
    @IBOutlet weak var outterOptionsTable: UITableView!
    
    @IBOutlet weak var typeTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var extraTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var outterTableHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    @IBAction func addOutterOption(_ sender: Any) {
        let foodOtions1 = FoodOptions()
        foodOtions1.name = ""
        let foodOption = FoodOption()
        foodOption.name = ""
        foodOtions1.options.append(foodOption)
        self.foodOptions.append(foodOtions1)
        self.outterOptionsTable.reloadData()
        self.reculculateOutTableHeight()
        
    }
    
    @IBAction func typeAdd(_ sender: Any) {
        let type1 = FoodType()
        type1.name = ""
        type1.money = ""
        foodTypes.append(type1)
        
        typeTable.reloadData()
        recalculateTypeTableHeight()
    }
    
    @IBAction func extraAdd(_ sender: Any) {
        let extra1 = FoodExtra()
        extra1.name = ""
        extra1.money = ""
        foodExtras.append(extra1)
        
        extraTable.reloadData()
        recalculateExtraTableHeight()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----------------------------------------------------------------------------------
        typeTable.dataSource = self
        typeTable.delegate = self
        typeTable.borderColor = UIColor.gray
        typeTable.borderWidth = 1
        setupTypesData()
        typeTable.reloadData()
        recalculateTypeTableHeight()
        //----------------------------------------------------------------------------------
        extraTable.dataSource = self
        extraTable.delegate = self
        extraTable.borderColor = UIColor.gray
        extraTable.borderWidth = 1
        setupExtrasData()
        extraTable.reloadData()
        recalculateExtraTableHeight()
        //----------------------------------------------------------------------------------
        
        outterOptionsTable.dataSource = self
        typeTable.delegate = self
        setupOptionsData()
        reculculateOutTableHeight()
        
    }
    
    func recalculateTypeTableHeight(){
        typeTableHeightConstraint.constant = CGFloat(40 * foodTypes.count)
        reculculateAllHeightForScrollView()
    }
    
    func recalculateExtraTableHeight(){
        extraTableHeightConstraint.constant = CGFloat(40 * foodExtras.count)
        reculculateAllHeightForScrollView()
    }

    
    func reculculateOutTableHeight(){
        var innnerCellSize = 0;
        for foodOption in foodOptions{
            innnerCellSize += 50 + (foodOption.options.count)*40
        }
        outterTableHeightConstraint.constant = CGFloat(innnerCellSize)
        reculculateAllHeightForScrollView()
    }
    
    func reculculateAllHeightForScrollView(){
        
        let type = typeTableHeightConstraint.constant
        let extra = extraTableHeightConstraint.constant
        let outter = outterTableHeightConstraint.constant
        var header = CGFloat(370)
        header += type+extra+outter
        scrollViewHeight.constant = header
    }
    
    func setupTypesData(){
        let type1 = FoodType()
        type1.name = "大杯"
        type1.money = "40"
        foodTypes.append(type1)
        let type2 = FoodType()
        type2.name = "中杯"
        type2.money = "40"
        foodTypes.append(type2)
        let type3 = FoodType()
        type3.name = "小杯"
        type3.money = "40"
        foodTypes.append(type3)
    }
    
    func setupExtrasData(){
        let extra1 = FoodExtra()
        extra1.name = "大杯"
        extra1.money = "40"
        foodExtras.append(extra1)
        let extra2 = FoodExtra()
        extra2.name = "中杯"
        extra2.money = "40"
        foodExtras.append(extra2)
        let extra3 = FoodExtra()
        extra3.name = "小杯"
        extra3.money = "40"
        foodExtras.append(extra3)
    }
    
    func setupOptionsData(){
        let sweetOption = FoodOptions()
        sweetOption.name = "甜度"
        let sweet1 = FoodOption()
        sweet1.name = "全糖"
        sweetOption.options.append(sweet1)
        let sweet2 = FoodOption()
        sweet2.name = "半糖"
        sweetOption.options.append(sweet2)
        
        let iceOption = FoodOptions()
        iceOption.name = "冰塊"
        let ice1 = FoodOption()
        ice1.name = "正常"
        iceOption.options.append(ice1)
        let ice2 = FoodOption()
        ice2.name = "少冰"
        iceOption.options.append(ice2)
        
        
        foodOptions.append(sweetOption)
        foodOptions.append(iceOption)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension FoodDetailVC : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == typeTable{
            return foodTypes.count
        }else if tableView == extraTable{
            return foodExtras.count
        }else if tableView == outterOptionsTable{
            return foodOptions.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == typeTable{
            let cellIdentifier = "TypeCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodDetailTypeTVCell
            cell.name.text = foodTypes[indexPath.row].name
            cell.money.text = foodTypes[indexPath.row].money
            cell.delete.tag = indexPath.row
            cell.delete.addTarget(self, action: #selector(typeDelete(sender:)), for: .touchUpInside)
            cell.name.tag = indexPath.row
            cell.name.addTarget(self, action: #selector(typeNameWasChange(_:)),for: UIControlEvents.editingDidEnd)
            cell.money.tag = indexPath.row
            cell.money.addTarget(self, action: #selector(typeMoneyDidChange(_:)),for: UIControlEvents.editingDidEnd)
            return cell
        }else if tableView == extraTable{
            let cellIdentifier = "ExtraCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodDetailExtraTVCell
            cell.name.text = foodExtras[indexPath.row].name
            cell.money.text = foodExtras[indexPath.row].money
            cell.delete.tag = indexPath.row
            cell.delete.addTarget(self, action: #selector(extraDelete(sender:)), for: .touchUpInside)
            cell.name.tag = indexPath.row
            cell.name.addTarget(self, action: #selector(extraNameWasChange(_:)),for: UIControlEvents.editingDidEnd)
            cell.money.tag = indexPath.row
            cell.money.addTarget(self, action: #selector(extraMoneyDidChange(_:)),for: UIControlEvents.editingDidEnd)
            return cell
        }else if tableView == outterOptionsTable{
            print(indexPath.row,indexPath.section,"in outterOptionName")
            let cellIdentifier = "OutterCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodDetailOutterOptionTVCell
            cell.outterOptionName.text = foodOptions[indexPath.row].name
            cell.outterOptionName.tag = indexPath.row
            cell.outterOptionName.addTarget(self, action: #selector(outterOptionChange(_:)),for: UIControlEvents.editingDidEnd)
            cell.innerOption = foodOptions[indexPath.row].options
            cell.innerTableHiehgtConstraint.constant = CGFloat(foodOptions[indexPath.row].options.count*40)
            cell.outterDeleteButton.tag = indexPath.row
            cell.outterDeleteButton.addTarget(self, action: #selector(outterOptionDelete(sender:)), for: .touchUpInside)
            cell.innerOptionAdd.tag = indexPath.row
            cell.outterTableIndex =  indexPath.row
            cell.delegate = self
            return cell
        }else{
            let cellIdentifier = "TypeCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodDetailTypeTVCell
            return cell
        }
    }
    //----------------------------------------------------
    @objc func typeDelete(sender : UIButton!) {
        foodTypes.remove(at: sender.tag )
        typeTable.reloadData()
        recalculateTypeTableHeight()
        
    }
    @objc func typeNameWasChange(_ textField: UITextField) {
        foodTypes[textField.tag].name = textField.text!
    }
    @objc func typeMoneyDidChange(_ textField: UITextField!) {
        foodTypes[textField.tag].money = textField.text!
    }
    //----------------------------------------------------
    @objc func extraDelete(sender : UIButton!) {
        foodExtras.remove(at: sender.tag )
        extraTable.reloadData()
        recalculateExtraTableHeight()
    }
    @objc func extraNameWasChange(_ textField: UITextField) {
        foodExtras[textField.tag].name = textField.text!
    }
    @objc func extraMoneyDidChange(_ textField: UITextField!) {
        foodExtras[textField.tag].money = textField.text!
    }
    //----------------------------------------------------

    @objc func outterOptionDelete(sender : UIButton!) {
        foodOptions.remove(at: sender.tag )
        outterOptionsTable.reloadData()
        reculculateOutTableHeight()
    }
    @objc func outterOptionChange(_ textField: UITextField) {
        foodOptions[textField.tag].name = textField.text!
    }

    
}
