//
//  RestaurantStoreInfoViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class RestaurantStoreInfoVC: UIViewController {
    
    var itemClass = ["老闆推薦", "現榨果汁系列", "特調系列", "熱飲系列"]

    var dataIndex : Int!
    var username:String = ""
    
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var restaurantTableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        print(self.dataIndex)
        //storeName?.text = username
        //self.loadTabBarController(atIndex: 1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



    
}


extension RestaurantStoreInfoVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantStoreInfoTVCell
        cell.itemClass.text = itemClass[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RestaurantStoreItemVC
        {
            //let vc = segue.destination as? RestaurantStoreItemViewController
            //vc?.username = "Arthur Dent"
        }
    }

}
