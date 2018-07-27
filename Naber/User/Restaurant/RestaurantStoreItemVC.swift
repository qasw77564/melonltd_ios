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


class RestaurantStoreItemVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categoryRel : RestaurantCategoryRelVo!
    var foodList: [FoodVo?] = []
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        self.loadData(refresh: true)
    }
    
    
    func loadData(refresh: Bool) {
        if refresh {
            self.foodList.removeAll()
            self.tableView.reloadData()
        }
        
        if self.categoryRel != nil {
            let uuid : String = self.categoryRel.category_uuid
            ApiManager.restaurantFoodList(uuid: uuid, ui: self, onSuccess: { foods in
                self.foodList.append(contentsOf: foods)
                self.tableView.reloadData()
            }) { err_msg in
                print(err_msg)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.categoryRel.category_name)
        self.loadData(refresh: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantStoreItemTVCell
        
        cell.name.text = self.foodList[indexPath.row]?.food_name
        cell.price.text = "$ " + (self.foodList[indexPath.row]?.default_price)!
        cell.photo.image = UIImage(named: "Logo")
        if self.foodList[indexPath.row]?.photo != nil {
            cell.photo.setImage(with: URL(string: (self.foodList[indexPath.row]?.photo)!), transformer: TransformerHelper.transformer(identifier: (self.foodList[indexPath.row]?.photo)!))
        }else {
            cell.photo.image = UIImage(named: "Logo")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreSelect") as! RestaurantStoreSelectVC
        vc.food = self.foodList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreSelect") as! RestaurantStoreSelectVC
////        vc.restaurantIndex = indexPath.row
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}

