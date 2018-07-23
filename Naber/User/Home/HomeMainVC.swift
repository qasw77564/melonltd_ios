//
//  HomeUserTableTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
//import MapleBacon

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

class HomeMainVC: UIViewController,UITableViewDataSource, UITableViewDelegate ,FSPagerViewDataSource, FSPagerViewDelegate{
    
    
    // 輪播圖 start
    fileprivate var advertisements : [AdvertisementVo?] = []
    fileprivate var adUIImages : [UIImageView] = []
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = .zero
            self.pagerView.automaticSlidingInterval = 3.0
            self.pagerView.isInfinite = true
        }
    }
 
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.advertisements.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .normal)
            self.pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .selected)
            self.pageControl.interitemSpacing = 12
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        }
    }
    // 輪播圖 end
    
    // test data
    var storeInfos = [StoreInfoClass]()
    var storeName = ["Berkeley Cafe", "Black Cafe", "Black Ring Coffee", "Camber Coffee", "Coffee Shop"]
    var workStatus = ["該商家尚未營業", "今天不營業", "Cool", "Cosy", "Classy"]
    var distance = ["1.3公里", "1.4公里", "1.3公里", "1.3公里", "1.3公里"]
    var time = ["12:00~13:00", "12:00~13:00","12:00~13:00","12:00~13:00","12:00~13:00",]
    var address = ["桃園市桃園區中山路100號", "桃園市桃園區中山路200號", "桃園市桃園區中山路300號", "桃園市桃園區中山路400號", "桃園市桃園區中山路500號"]
    var storeImage = ["Logo", "Logo", "blackRingCoffee", "camberCoffee", "coffeeShop"]

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
        
        for i in storeName {
            let index = storeName.index(of: i)
            let storeInfo = StoreInfoClass()
            storeInfo.storeName = storeName[index!]
            storeInfo.workStatus = workStatus[index!]
            storeInfo.distance = distance[index!]
            storeInfo.time = time[index!]
            storeInfo.address = address[index!]
            storeInfo.storeImage = storeImage[index!]
            storeInfos.append(storeInfo)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        // 加載輪播圖
        ApiManager.advertisement(ui: self, onSuccess: { advertisements in
            // List<T> .clear().
            self.advertisements.removeAll()
            // List<T> .addAll().
            self.advertisements.append(contentsOf: advertisements)
            self.pageControl.numberOfPages = self.advertisements.count

            // 處理網路圖像加載
            self.advertisements.forEach({ ad in
                let image :UIImageView = UIImageView.init();
                image.setImage(with: URL(string: (ad?.photo)!), transformer: TransformerHelper.transformer(identifier: (ad?.photo)!))
                self.adUIImages.append(image)
            })
            self.pagerView.reloadData()
        }) { err_msg in
            print(err_msg)
        }

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

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 112
//    }
    
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

    // MARK:- FSPagerView DataSource
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.advertisements.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if self.adUIImages[index].image == nil {
            cell.imageView?.image = UIImage(named: "naber_default_image.png")
        }else {
            cell.imageView?.image = self.adUIImages[index].image
        }
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        // Or Use KVO with property "currentIndex"
        self.pageControl.currentPage = pagerView.currentIndex
    }

    
    
}
