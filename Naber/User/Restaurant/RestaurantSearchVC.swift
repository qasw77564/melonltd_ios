//
//  RestaurantSearchViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import CoreLocation


class RestaurantSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate , CLLocationManagerDelegate {

    var LM : CLLocationManager!; //座標管理元件
    var location : CLLocation!
    var reqData: ReqData! = Optional.none
    var templates: [[String]] = []
    
    @IBOutlet weak var filterName: UILabel!
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
    
    func loadData(refresh: Bool){
        if refresh {
            Model.TMPE_RESTAURANT_LIST.removeAll()
            self.tableView.reloadData()
            self.reqData.page = 0
            self.reqData.loadingMore = true
        }
        
        self.reqData.loadingMore = false
        if self.reqData != nil {
            self.reqData.page = self.reqData.page + 1
            if self.reqData.search_type.elementsEqual("DISTANCE") {
                self.reqData.uuids = []
                self.reqData.uuids.append(contentsOf: self.templates[self.reqData.page - 1])
            }
            ApiManager.restaurantList(req: self.reqData, ui: self, onSuccess: { restaurantInfos in
                if self.reqData.search_type.elementsEqual("DISTANCE") {
                    restaurantInfos.forEach{ tmp in
                        let lant: Double = Double(tmp.latitude)!
                        let long: Double = Double(tmp.longitude)!
                        let distance: Double = self.location.distance(from: CLLocation.init(latitude: lant, longitude: long))
                        tmp.distance = distance
                    }
                    var list = restaurantInfos
                    list.sort(by: { (o1, o2) -> Bool in
                        return o1.distance < o2.distance
                    })
                    Model.TMPE_RESTAURANT_LIST.append(contentsOf: list)
                    // 計算距離模板有幾頁
                    self.reqData.loadingMore = self.templates.count > self.reqData.page;
                }else {
                    Model.TMPE_RESTAURANT_LIST.append(contentsOf: restaurantInfos)
                    self.reqData.loadingMore = restaurantInfos.count % NaberConstant.PAGE == 0 && restaurantInfos.count != 0
                }
                self.tableView.reloadData()
            }) { err_msg in
                print(err_msg)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reqData = ReqData()
        self.enableBasicLocationServices()
        self.searchForDistance(UIButton.init())
    }
    
    @IBAction func searchForDistance (_ sender: UIButton){
        self.filterName.text = "離我最近"
        self.reqData.search_type = "DISTANCE";
        self.reqData.category = ""
        self.reqData.area = ""
        self.reqData.loadingMore = false
        self.reqData.uuids = []
        self.templates = []
        self.enableBasicLocationServices()
        if self.LM.location != nil {
            self.location = self.LM.location!
            ApiManager.restaurantTemplate(ui: self, onSuccess: { tmps in
                tmps.forEach{ tmp in
                    let lant: Double = Double(tmp!.latitude)!
                    let long: Double = Double(tmp!.longitude)!
                    let distance: Double = self.location.distance(from: CLLocation.init(latitude: lant, longitude: long))
                    tmp?.distance = distance
                }
                var list = tmps
                list.sort(by: {(o1, o2) -> Bool in
                    return o1!.distance < o2!.distance
                })

                var uuids: [String] = []
                for index in 0..<list.count {
                    if index % 10 != 0 || index == 0 {
                        uuids.append((list[index]?.restaurant_uuid)!)
                    } else if index % 10 == 0 && index != 0 {
                        self.templates.append(uuids)
                        uuids = []
                        uuids.append((list[index]?.restaurant_uuid)!)
                    }
                    if index == list.count - 1 {
                        self.templates.append(uuids)
                    }
                }
                self.reqData.uuids.append(contentsOf: self.templates[0])
                self.loadData(refresh: true)
            }) { err_msg in
                print(err_msg)
            }
        }
    }
    
    @IBAction func searchForArea (_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "請選擇區域", style: .destructive))
        NaberConstant.FILTER_AREAS.forEach{ name in
            let itemAction = UIAlertAction(title: name, style: .default) { itemAction in
                self.reqData.search_type = "AREA"
                self.reqData.area = name
                self.reqData.category = ""
                self.reqData.uuids = []
                self.filterName.text = name
                self.loadData(refresh: true)
            }
            alert.addAction(itemAction)
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        self.present(alert, animated: false, completion: nil)
    }
    
    @IBAction func searchForCategory (_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "請選擇種類", style: .destructive))
        NaberConstant.FILTER_CATEGORYS.forEach{ name in
            let itemAction = UIAlertAction(title: name, style: .default) { itemAction in
                self.reqData.search_type = "CATEGORY";
                self.reqData.category = name
                self.filterName.text = name
                self.reqData.area = ""
                self.reqData.uuids = []
                self.loadData(refresh: true)
            }
            alert.addAction(itemAction)
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        self.present(alert, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.TMPE_RESTAURANT_LIST.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoVC
        vc.restaurantIndex = indexPath.row
        vc.pageType = .RESTAURANT
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
        
        cell.name.text = Model.TMPE_RESTAURANT_LIST[indexPath.row].name
        cell.address.text = Model.TMPE_RESTAURANT_LIST[indexPath.row].address
        cell.time.text = Model.TMPE_RESTAURANT_LIST[indexPath.row].store_start + " ~ " + Model.TMPE_RESTAURANT_LIST[indexPath.row].store_end
        if Model.TMPE_RESTAURANT_LIST[indexPath.row].photo != nil {
            cell.photo.setImage(with: URL(string: Model.TMPE_RESTAURANT_LIST[indexPath.row].photo), transformer: TransformerHelper.transformer(identifier: Model.TMPE_RESTAURANT_LIST[indexPath.row].photo))
        }else {
            cell.photo.image = UIImage(named: "Logo")
        }
        
        cell.workStatus.textColor = UIColor.init(red: 234/255, green: 33/255, blue: 5/255, alpha: 1.0)
        if Model.TMPE_RESTAURANT_LIST[indexPath.row].not_business.count > 0 {
            cell.workStatus.text = "今日不營業"
        } else if Model.TMPE_RESTAURANT_LIST[indexPath.row].is_store_now_open.uppercased().elementsEqual("FALSE") {
            cell.workStatus.text = "該商家尚未營業"
        } else {
            cell.workStatus.text = "接單中"
            cell.workStatus.textColor = UIColor.init(red: 128/255, green: 228/255, blue: 56/255, alpha: 1.0)
        }
        
        if self.location != nil {
            let lant: Double = Double(Model.TMPE_RESTAURANT_LIST[indexPath.row].latitude)!
            let long: Double = Double(Model.TMPE_RESTAURANT_LIST[indexPath.row].longitude)!
            let distance: Double = self.location!.distance(from: CLLocation.init(latitude: lant, longitude: long))
            cell.distance.text = String(format: "%.01f 公里", (distance / 1000) < 0.1 ? 0.1 : (distance / 1000))
        } else {
            cell.distance.text = ""
        }
        
        if Model.TMPE_RESTAURANT_LIST.count - 1 == indexPath.row  && self.reqData.loadingMore {
            print("load mode")
            self.loadData(refresh: false)
        }
        
        return cell
    }

    
    // GPS
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

