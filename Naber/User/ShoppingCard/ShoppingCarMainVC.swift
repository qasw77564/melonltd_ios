//
//  ShoppingCarMainViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/28.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class ShoppingCarMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 使用者購物車資料 使用外部物件操控
    // Model.USER_CACHE_SHOPPING_CART
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
        sender.endRefreshing()
        UserSstorage.setShoppingCartDatas(datas: Model.USER_CACHE_SHOPPING_CART)
        Model.USER_CACHE_SHOPPING_CART.removeAll()
        Model.USER_CACHE_SHOPPING_CART.append(contentsOf: UserSstorage.getShoppingCartDatas())
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Model.USER_CACHE_SHOPPING_CART.removeAll()
        Model.USER_CACHE_SHOPPING_CART.append(contentsOf: UserSstorage.getShoppingCartDatas())
        print(Model.USER_CACHE_SHOPPING_CART)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Main tableView 先計算高度 給 main cell ， sun tableView 才能正常顯示出來
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (CGFloat(Model.USER_CACHE_SHOPPING_CART[indexPath.row].orders.count * 96 + 109))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.USER_CACHE_SHOPPING_CART.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingCarMainTVCell
        cell.cellWillAppear()
        cell.tag = indexPath.row
        cell.storeName.text = Model.USER_CACHE_SHOPPING_CART[indexPath.row].restaurant_name
        cell.cancelOrder.tag = indexPath.row
        cell.cancelOrder.addTarget(self, action: #selector(cancelOrder), for: .touchUpInside)
        cell.itemTable.reloadData()
        return cell
    }

    @IBAction func changedShoppingCartDatas(_ sender: Any) {
        UserSstorage.setShoppingCartDatas(datas: Model.USER_CACHE_SHOPPING_CART)
        Model.USER_CACHE_SHOPPING_CART.removeAll()
        Model.USER_CACHE_SHOPPING_CART.append(contentsOf: UserSstorage.getShoppingCartDatas())
        print(Model.USER_CACHE_SHOPPING_CART)
        self.tableView.reloadData()
    }
    
    
    @objc func cancelOrder(_ sender: UIButton){
        Model.USER_CACHE_SHOPPING_CART.remove(at: sender.tag)
        UserSstorage.setShoppingCartDatas(datas: Model.USER_CACHE_SHOPPING_CART)
        Model.USER_CACHE_SHOPPING_CART.removeAll()
        Model.USER_CACHE_SHOPPING_CART.append(contentsOf: UserSstorage.getShoppingCartDatas())
        print(Model.USER_CACHE_SHOPPING_CART)
        self.tableView.reloadData()
    }
}


