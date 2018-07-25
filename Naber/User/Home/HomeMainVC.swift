//
//  HomeUserTableTableViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
//import MapleBacon
import CoreLocation

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
            self.pageControl.numberOfPages = Model.ADVERTISEMENTS.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .normal)
            self.pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)), for: .selected)
            self.pageControl.interitemSpacing = 12
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        }
    }

    @IBOutlet weak var storeTableView: UITableView! {
        didSet {
            self.storeTableView.dataSource = self
            self.storeTableView.delegate = self
            let refreshControl: UIRefreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)])
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            refreshControl.tintColor = UIColor.clear
            self.storeTableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(sender: UIRefreshControl){
//        startLoadDeviceStats()
        Model.TOP_RESTAURANT_LIST.removeAll()
        sender.endRefreshing()
        self.storeTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 加載輪播圖
        ApiManager.advertisement(ui: self, onSuccess: { advertisements in
            Model.ADVERTISEMENTS.removeAll()
            Model.ADVERTISEMENTS.append(contentsOf: advertisements)
            self.pageControl.numberOfPages = Model.ADVERTISEMENTS.count

            // 處理網路圖像加載
            Model.ADVERTISEMENTS.forEach({ ad in
                let image :UIImageView = UIImageView.init();
                image.setImage(with: URL(string: ad.photo), transformer: TransformerHelper.transformer(identifier: ad.photo!))
                self.adUIImages.append(image)
            })
            self.pagerView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
        
        Model.TOP_RESTAURANT_LIST.removeAll()
        let req : ReqData = ReqData()
        req.search_type = "TOP"
        ApiManager.restaurantList(req: req, ui: self, onSuccess: { restaurantInfos in
            Model.TOP_RESTAURANT_LIST = restaurantInfos
            self.storeTableView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
    }
    
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
        cell.storeName.text = Model.TOP_RESTAURANT_LIST[indexPath.row].name
        cell.address.text = Model.TOP_RESTAURANT_LIST[indexPath.row].address
//        cell.workStatus.text = storeInfos[indexPath.row].workStatus
//        cell.distance.text = storeInfos[indexPath.row].distance

        cell.workStatus.isHidden = true
        
        let locationManager = CLLocationManager()
        let distance: Double = locationManager.location!.distance(from:  CLLocation (latitude: Double(Model.TOP_RESTAURANT_LIST[indexPath.row].latitude)!, longitude: Double(Model.TOP_RESTAURANT_LIST[indexPath.row].longitude)!))
        print(distance)
        
        cell.time.text = Model.TOP_RESTAURANT_LIST[indexPath.row].store_start + Model.TOP_RESTAURANT_LIST[indexPath.row].store_end
        if  Model.TOP_RESTAURANT_LIST[indexPath.row].photo != nil {
                cell.thumbnailImageView.setImage(with: URL(string: Model.TOP_RESTAURANT_LIST[indexPath.row].photo), transformer: TransformerHelper.transformer(identifier: Model.TOP_RESTAURANT_LIST[indexPath.row].photo))
        }
        
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
        return Model.TOP_RESTAURANT_LIST.count
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
        return Model.ADVERTISEMENTS.count
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
