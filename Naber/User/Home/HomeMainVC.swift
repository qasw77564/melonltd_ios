//
//  HomeUserTableTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit

class StoreInfoClass {
    //等於Objective-C的 @property (strong) NSString *city;
    var storeName:String = ""
    var workStatus:String = ""
    var distance:String = ""
    var time:String = ""
    var address:String = ""
    var storeImage:String = ""
    
    //一個Class的宣告，在有效的Scope內預設就會有 init
    //init(){
    //
    //}
}

class HomeMainVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var storeInfos = [StoreInfoClass]()

    var storeName = ["Berkeley Cafe", "Black Cafe", "Black Ring Coffee", "Camber Coffee", "Coffee Shop"]
    
    var workStatus = ["Cosy", "Classy", "Cool", "Cosy", "Classy"]

    var distance = ["100M", "200M", "300M", "400M", "500M"]

    var time = ["AM08:00~PM10:00", "AM08:00~PM10:00", "AM08:00~PM10:00", "AM08:00~PM10:00", "AM08:00~PM10:00"]
    
    var address = ["桃園市桃園區中山路100號", "桃園市桃園區中山路200號", "桃園市桃園區中山路300號", "桃園市桃園區中山路400號", "桃園市桃園區中山路500號"]
    
    var storeImage = ["berkeleyCafe", "blackCoffee", "blackRingCoffee", "camberCoffee", "coffeeShop"]

    @IBOutlet weak var storeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTableView.delegate = self
        storeTableView.dataSource = self
        
        
        let storeInfo = StoreInfoClass()
        storeInfo.storeName="Berkeley Cafe"
        storeInfo.workStatus="Cosy"
        storeInfo.distance="100M";
        storeInfo.time="AM08:00~PM10:00";
        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
        storeInfo.storeImage="berkeleyCafe";
        storeInfos.append(storeInfo)
        storeInfos.append(storeInfo)
        storeInfos.append(storeInfo)
        storeInfos.append(storeInfo)
        storeInfos.append(storeInfo)
        storeInfos.append(storeInfo)

        
        for store in storeInfos {
            print(store.storeName)
            print(store.workStatus)
            print(store.distance)
            print(store.time)
            print(store.address)
            print(store.storeImage)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
        // Configure the cell...
//        cell.storeName.text = storeName[indexPath.row]
//        cell.address.text = address[indexPath.row]
//        cell.workStatus.text = workStatus[indexPath.row]
//        cell.distance.text = distance[indexPath.row]
//        cell.time.text = time[indexPath.row]
//        cell.thumbnailImageView.image = UIImage(named: storeImage[indexPath.row])
        
        cell.storeName.text = storeInfos[indexPath.row].storeName
        cell.address.text = storeInfos[indexPath.row].address
        cell.workStatus.text = storeInfos[indexPath.row].workStatus
        cell.distance.text = storeInfos[indexPath.row].distance
        cell.time.text = storeInfos[indexPath.row].time
        cell.thumbnailImageView.image = UIImage(named: storeInfos[indexPath.row].storeImage)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return storeName.count
        return storeInfos.count

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoVC
        //self.present(newViewController, animated: true, completion: nil)

        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
//    var tabBarIndex: Int?
//    
//    //function that will trigger the **MODAL** segue
//    private func loadTabBarController(atIndex: Int){
//        self.tabBarIndex = atIndex
//        self.performSegue(withIdentifier: "HomeMainStore", sender: self)
//       
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.destination is RestaurantStoreInfoViewController
//        {
//            let vc = segue.destination as? RestaurantStoreInfoViewController
//            vc?.username = "Arthur Dent"
//            //self.loadTabBarController(atIndex: 1)
//        }
//    }


}
