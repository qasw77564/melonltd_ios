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

class HomeMainVC: UIViewController,UITableViewDataSource, UITableViewDelegate ,FSPagerViewDataSource, FSPagerViewDelegate, CLLocationManagerDelegate{
    
    var LM : CLLocationManager!; //座標管理元件
    var location : CLLocation!
    
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
        sender.endRefreshing()
        self.loadData(refresh: true)
    }
 
    
    func loadData(refresh: Bool){
        if refresh {
            Model.TOP_RESTAURANT_LIST.removeAll()
            self.storeTableView.reloadData()
        }

        // 重新取得定位
        self.location = self.LM.location
        let req : ReqData = ReqData()
        req.search_type = "TOP"
        ApiManager.restaurantList(req: req, ui: self, onSuccess: { restaurantInfos in
            Model.TOP_RESTAURANT_LIST.append(contentsOf: restaurantInfos)
            self.storeTableView.reloadData()
        }) { err_msg in
            print(err_msg)
            self.storeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 確認 GPS 權限
        enableBasicLocationServices()
        
        // 加載輪播圖
        ApiManager.advertisement(ui: self, onSuccess: { advertisements in
            Model.ADVERTISEMENTS.removeAll()
            Model.ADVERTISEMENTS.append(contentsOf: advertisements)
            self.pageControl.numberOfPages = Model.ADVERTISEMENTS.count
            self.pagerView.reloadData()
        }) { err_msg in
            print(err_msg)
        }
        
        ApiManager.bulletin(ui: self, onSuccess: { bulletins in
            Model.ALL_BULLETINS.removeAll()
            Model.NABER_BULLETINS.removeAll()
            bulletins.forEach({ b in
                Model.ALL_BULLETINS[(b?.bulletin_category)!] = b?.content_text
            })
            let naberBulletins: [String] = Model.ALL_BULLETINS["HOME"]!.components(separatedBy: "$split")
            Model.NABER_BULLETINS.append(contentsOf: naberBulletins)
            
        }) { err_msg in
            print(err_msg)
        }
        
        self.loadData(refresh: true)
    }
    
   override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
        
        cell.storeName.text = Model.TOP_RESTAURANT_LIST[indexPath.row].name
        cell.address.text = Model.TOP_RESTAURANT_LIST[indexPath.row].address
        cell.time.text = Model.TOP_RESTAURANT_LIST[indexPath.row].store_start + " ~ " + Model.TOP_RESTAURANT_LIST[indexPath.row].store_end
        if Model.TOP_RESTAURANT_LIST[indexPath.row].photo != nil {
            cell.thumbnailImageView.setImage(with: URL(string: Model.TOP_RESTAURANT_LIST[indexPath.row].photo), transformer: TransformerHelper.transformer(identifier: Model.TOP_RESTAURANT_LIST[indexPath.row].photo))
        }else {
            cell.thumbnailImageView.image = UIImage(named: "Logo")
        }
        
        cell.workStatus.textColor = UIColor.init(red: 234/255, green: 33/255, blue: 5/255, alpha: 1.0)
        if Model.TOP_RESTAURANT_LIST[indexPath.row].not_business.count > 0 {
            cell.workStatus.text = "今日不營業"
        } else if Model.TOP_RESTAURANT_LIST[indexPath.row].is_store_now_open.uppercased() == "FALSE" {
            cell.workStatus.text = "該商家尚未營業"
        } else {
            cell.workStatus.text = "接單中"
            cell.workStatus.textColor = UIColor.init(red: 128/255, green: 228/255, blue: 56/255, alpha: 1.0)
        }
        
        if self.location != nil {
            let lant: Double = Double(Model.TOP_RESTAURANT_LIST[indexPath.row].latitude)!
            let long: Double = Double(Model.TOP_RESTAURANT_LIST[indexPath.row].longitude)!
            let distance: Double = self.location!.distance(from: CLLocation.init(latitude: lant, longitude: long))
            cell.distance.text = String(format: "%.01f 公里", (distance / 1000) < 0.1 ? 0.1 : (distance / 1000))
        } else {
            cell.distance.text = ""
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
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoVC
        vc.dataIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }


    // MARK:- FSPagerView DataSource
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return Model.ADVERTISEMENTS.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if let photo: String? = Model.ADVERTISEMENTS[index].photo {
            cell.imageView?.setImage(with: URL(string: photo!), transformer: TransformerHelper.transformer(identifier: photo!))
        }else {
           cell.imageView?.image = UIImage(named: "naber_default_image.png")
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
    
    override func viewDidDisappear(_ animated: Bool) {
        //因為ＧＰＳ功能很耗電,所以被敬執行時關閉定位功能
        self.LM.stopUpdatingLocation();
    }

    func enableBasicLocationServices() {
        self.LM = CLLocationManager()
        self.LM.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            LM.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            LM.startUpdatingLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus ) {
        switch status {
        case .restricted, .denied:
            let alertController = UIAlertController( title: "定位權限已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "確認", style: .default, handler:nil))
            self.present(alertController, animated: true, completion: nil)
            break
        case .authorizedWhenInUse:
            self.LM.startUpdatingLocation()
            break
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    
}
