//
//  FoodClassVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/9.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class FoodClass {
    var name:String = ""
    var switchButton:Bool = false
    var delete:Bool = false
    var editor:Bool = false
    var pictureName = ""
    var money = ""
}
class FoodClassVC: UIViewController {
    var seriasName = ""
    var foodClasses = [FoodClass]()
    @IBOutlet weak var foodItemTable: UITableView!

    @IBOutlet weak var addFoodClass: DesignableButton!

    @IBOutlet weak var foodClaasName: UILabel!

    @IBAction func addFoodClass(_ sender: Any) {
        //TODO
    }
    
    func setupData(){
        
        let food1 = FoodClass()
        food1.name="種類一"
        food1.switchButton = false
        food1.delete = false //預留
        food1.editor = false //預留
        
        let food2 = FoodClass()
        food2.name="種類二"
        food2.switchButton = true
        food2.delete = false //預留
        food2.editor = false //預留
        
        let food3 = FoodClass()
        food3.name="種類三"
        food3.switchButton = true
        food3.delete = false //預留
        food3.editor = false //預留
        
        foodClasses.append(food1)
        foodClasses.append(food2)
        foodClasses.append(food3)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        foodItemTable.dataSource=self
        foodItemTable.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension FoodClassVC : UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodClassTVCell
        
        cell.name.text = foodClasses[indexPath.row].name
        cell.switchButton.setOn(foodClasses[indexPath.row].switchButton, animated: false)
        
        cell.delete.tag = indexPath.row
        cell.delete.addTarget(self, action: #selector(delete(sender:)), for: .touchUpInside)
        
        cell.editor.addTarget(self, action: #selector(editor(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func delete(sender : UIButton!) {
        foodClasses.remove(at: sender.tag )
        foodItemTable.reloadData()
    }
    
    @objc func editor(sender : UIButton!) {
        
        //TODO
    }
    
    
}
