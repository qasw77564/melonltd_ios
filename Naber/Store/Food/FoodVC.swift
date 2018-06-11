//
//  FoodVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/8.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class Food {
    var name:String = ""
    var switchButton:Bool = false
    var delete:Bool = false
    var editor:Bool = false
    
}

class FoodVC: UIViewController {

    var foods = [Food]()
    
    @IBOutlet weak var foodTable: UITableView!
    
    @IBOutlet weak var foodClassName: DesignableTextField!
    
    @IBOutlet weak var addFoodClass: DesignableButton!
    
    
    @IBAction func addFoodAction(_ sender: Any) {
        
        let food1 = Food()
        food1.name = foodClassName.text!
        food1.switchButton = false
        food1.delete = false //預留
        food1.editor = false //預留
        foods.append(food1)
        foodTable.reloadData()
        foodClassName.text = ""
    }
    
    func setupData(){
        
        let food1 = Food()
        food1.name="種類一"
        food1.switchButton = false
        food1.delete = false //預留
        food1.editor = false //預留
        
        let food2 = Food()
        food2.name="種類二"
        food2.switchButton = true
        food2.delete = false //預留
        food2.editor = false //預留
        
        let food3 = Food()
        food3.name="種類三"
        food3.switchButton = true
        food3.delete = false //預留
        food3.editor = false //預留
        
        foods.append(food1)
        foods.append(food2)
        foods.append(food3)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        foodTable.delegate = self
        foodTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FoodVC : UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodTVCell
        
        cell.name.text = foods[indexPath.row].name
        cell.switchButton.setOn(foods[indexPath.row].switchButton, animated: false)
        
        cell.delete.tag = indexPath.row
        cell.delete.addTarget(self, action: #selector(delete(sender:)), for: .touchUpInside)

        cell.editor.addTarget(self, action: #selector(editor(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func delete(sender : UIButton!) {
        foods.remove(at: sender.tag )
        foodTable.reloadData()
    }
    
    @objc func editor(sender : UIButton!) {

        //TODO
    }
    
    
}

