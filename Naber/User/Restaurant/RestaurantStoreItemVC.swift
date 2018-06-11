//
//  RestaurantStoreItemViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/1.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantStoreItemClass {

    var itemName:String = ""
    var itemMoney:String = ""
    var itemImage:String = ""
}


class RestaurantStoreItemVC: UIViewController {

    @IBOutlet weak var itemTable: UITableView!
    
    var items = [RestaurantStoreItemClass]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTable.delegate = self
        itemTable.dataSource = self
        
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadItems(){
        let item1 = RestaurantStoreItemClass()
        item1.itemName="特調冷飲"
        item1.itemMoney="20$"
        item1.itemImage="berkeleyCafe"

        let item2 = RestaurantStoreItemClass()
        item2.itemName="特調冷飲"
        item2.itemMoney="20$"
        item2.itemImage="blackCoffee"


        let item3 = RestaurantStoreItemClass()
        item3.itemName="特調冷飲"
        item3.itemMoney="20$"
        item3.itemImage="blackRingCoffee"


        let item4 = RestaurantStoreItemClass()
        item4.itemName="特調冷飲"
        item4.itemMoney="20$"
        item4.itemImage="camberCoffee"

        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RestaurantStoreItemVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantStoreItemTVCell
        cell.itemName.text = items[indexPath.row].itemName
        cell.itemMoney.text = items[indexPath.row].itemMoney
        cell.itemImage.image = UIImage(named: items[indexPath.row].itemImage)
        return cell
    }


}
