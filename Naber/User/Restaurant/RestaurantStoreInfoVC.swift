//
//  RestaurantStoreInfoViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantStoreInfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categoryList: [RestaurantCategoryRelVo?] = []

    var restaurantIndex : Int! = nil
    var username:String = ""
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var workStatus: UILabel!
    @IBOutlet weak var backgroundPhoto: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var bulletin: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(refresh: true)        
    }
    
    func loadData(refresh: Bool){
        if refresh {
            self.categoryList.removeAll()
            self.tableView.reloadData()
        }
        if self.restaurantIndex != nil {
            let uuid: String = Model.TOP_RESTAURANT_LIST[self.restaurantIndex].restaurant_uuid
            ApiManager.restaurantCategoryList(uuid: uuid, ui: self, onSuccess: { restaurantCategorys in
                self.categoryList.append(contentsOf: restaurantCategorys)
                self.tableView.reloadData()
                
            }, onFail: { err_msg in
                print(err_msg)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantStoreInfoTVCell
        cell.name.text = self.categoryList[indexPath.row]?.category_name
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPa
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreItem") as! RestaurantStoreItemVC
        vc.categoryRel = self.categoryList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is RestaurantStoreItemVC {
//            //let vc = segue.destination as? RestaurantStoreItemViewController
//            //vc?.username = "Arthur Dent"
//        }
//    }
}


//extension RestaurantStoreInfoVC : UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemClass.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellIdentifier = "Cell"
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantStoreInfoTVCell
//        cell.itemClass.text = itemClass[indexPath.row]
//        return cell
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is RestaurantStoreItemVC {
//            //let vc = segue.destination as? RestaurantStoreItemViewController
//            //vc?.username = "Arthur Dent"
//        }
//    }
//}
