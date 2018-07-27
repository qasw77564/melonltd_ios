//
//  RestaurantSearchViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import CoreLocation


class RestaurantSearchVC: UIViewController {
//
//    var firstTable = [StoreInfoClass]()
//    var secondTable = [StoreInfoClass]()
//    var thirdTable = [StoreInfoClass]()
    
    var oldSelectSubOptionValue = 0;
    
    var LM : CLLocationManager!; //座標管理元件
    var location : CLLocation!
    
    @IBOutlet weak var selectSubOption: UILabel!
    @IBOutlet weak var segmentedChoose: UISegmentedControl!
    @IBOutlet weak var areaBtn: UIButton!
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var distanceBtn: UIButton!
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
            Model.TOP_RESTAURANT_LIST.removeAll()
            self.tableView.reloadData()
        }
        
        // 重新取得定位
        self.location = self.LM.location
        let req : ReqData = ReqData()
        req.search_type = "TOP"
        ApiManager.restaurantList(req: req, ui: self, onSuccess: { restaurantInfos in
            Model.TOP_RESTAURANT_LIST.append(contentsOf: restaurantInfos)
            self.tableView.reloadData()
        }) { err_msg in
            print(err_msg)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableBasicLocationServices()

//        initialFirstTable()
//        initialSecondTable()
//        initialThridTable()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchForDistance (_ sender: UIButton){
        print("sadad")
    }
    
    @IBAction func searchForArea (_ sender: UIButton){
        print("sadad")
    }
    
    @IBAction func searchForCategory (_ sender: UIButton){
                print("sadad")
    }
    
//    
//    @IBAction func switchTheTableViewBySegmentControl(_ sender: AnyObject) {
//        bottomAlert( sender )
//    }
//    
//    func initialFirstTable(){
//        let storeInfo = StoreInfoClass()
//        storeInfo.storeName="Berkeley Cafe"
//        storeInfo.workStatus="該商家尚未營業"
//        storeInfo.distance="1.7公里";
//        storeInfo.time="AM08:00~PM10:00";
//        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
//        storeInfo.storeImage="berkeleyCafe";
//        firstTable.append(storeInfo)
//        firstTable.append(storeInfo)
//        firstTable.append(storeInfo)
//    }
    
//    func initialSecondTable(){
//        let storeInfo = StoreInfoClass()
//        storeInfo.storeName="Berkeley Cafe"
//        storeInfo.workStatus="Cosy"
//        storeInfo.distance="100M";
//        storeInfo.time="AM08:00~PM10:00";
//        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
//        storeInfo.storeImage="berkeleyCafe";
//        secondTable.append(storeInfo)
//
//    }
    
//    func initialThridTable(){
//        let storeInfo = StoreInfoClass()
//        storeInfo.storeName="Berkeley Cafe"
//        storeInfo.workStatus="Cosy"
//        storeInfo.distance="100M";
//        storeInfo.time="AM08:00~PM10:00";
//        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
//        storeInfo.storeImage="berkeleyCafe";
//        thirdTable.append(storeInfo)
//        thirdTable.append(storeInfo)
//        thirdTable.append(storeInfo)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var returnValue = 0
//        switch (segmentedChoose.selectedSegmentIndex){
//        case 0:
//            returnValue = firstTable.count
//        case 1:
//            returnValue = secondTable.count
//        case 2:
//            returnValue = thirdTable.count
//        default:
//            break;
//        }
//        return returnValue
        return 1
    }
    
    
    func bottomAlert(_ sender: AnyObject ) {
        switch (segmentedChoose.selectedSegmentIndex){
            case 0:
                let sheet = addSheetClassForSwitchPopupAlert(dataArray: NaberConstant.FILTER_CATEGORYS, sender: AnyObject.self as AnyObject )
                self.present(sheet, animated: true, completion: nil)
            case 1:
                let sheet = addSheetClassForSwitchPopupAlert(dataArray: NaberConstant.FILTER_AREAS, sender: AnyObject.self as AnyObject )
                self.present(sheet, animated: true, completion: nil)
            case 2:
                self.oldSelectSubOptionValue = self.segmentedChoose.selectedSegmentIndex;
                self.selectSubOption.text = "距離"
                self.tableView.reloadData()
            default:
                break;
        }
        
    }
    
    func addSheetClassForSwitchPopupAlert (dataArray : Array<String> , sender: AnyObject ) -> UIAlertController {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let announceTitle = UIAlertAction(title: "請選擇", style: .destructive) { (_) in
            self.segmentedChoose.selectedSegmentIndex=self.oldSelectSubOptionValue;
        }
        
//        let defaultAction = UIAlertAction(title: "Default", style: .default, handler: { (alert: UIAlertAction!) -> Void in
//            //  Do some action here.
//        })
//
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
//            //  Do some destructive action here.
//        })
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
//            //  Do something here upon cancellation.
//        })
        
//
//        sheet.addAction(defaultAction)
//        sheet.addAction(deleteAction)
//        sheet.addAction(cancelAction)
        
//        if let popoverController = sheet.popoverPresentationController {
//            popoverController.barButtonItem = sender as! UIBarButtonItem
//        }
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            sheet.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            sheet.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
            sheet.popoverPresentationController?.sourceView = self.view
            sheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
        }
        
        
        sheet.addAction(announceTitle)
        
        for data in dataArray {
            let action = UIAlertAction(title: data, style: .default) { (action) in
                self.oldSelectSubOptionValue = self.segmentedChoose.selectedSegmentIndex;
                self.selectSubOption.text = data
                self.tableView.reloadData()
            }
            sheet.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel ) { (action) in
            self.segmentedChoose.selectedSegmentIndex=self.oldSelectSubOptionValue;
        }
        sheet.addAction(cancel)
        
        return sheet
        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RestaurantStoreInfoVC {
            let vc = segue.destination as? RestaurantStoreInfoVC
//            vc?.username = "Arthur Dent"
        }
    }
    

}

extension RestaurantSearchVC : UITableViewDataSource, UITableViewDelegate , CLLocationManagerDelegate{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 100
//    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoVC
        vc.restaurantIndex = 0
        vc.pageType = .RESTAURANT
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch (segmentedChoose.selectedSegmentIndex){
//
//
//
//        case 0:
//            print("You selected cell #\(firstTable[indexPath.row].storeName)!")
//            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
//        //            navigationController?.pushViewController(destination, animated: true)
//        case 1:
//            print("You selected cell #\(secondTable[indexPath.row].storeName)!")
//            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
//        //            navigationController?.pushViewController(destination, animated: true)
//        case 2:
//            print("You selected cell #\(thirdTable[indexPath.row].storeName)!")
//            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
//        //            navigationController?.pushViewController(destination, animated: true)
//        default:
//            break;
//        }
//
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let nextController = storyboard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoViewController
////        nextController.storeName.text = "Taylor Swift"
////        self.navigationController?.pushViewController(nextController, animated: true)
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
//        switch (segmentedChoose.selectedSegmentIndex){
//        case 0:
//            cell.name.text = firstTable[indexPath.row].storeName
//            cell.address.text = firstTable[indexPath.row].address
//            cell.workStatus.text = firstTable[indexPath.row].workStatus
//            cell.distance.text = firstTable[indexPath.row].distance
//            cell.time.text = firstTable[indexPath.row].time
//            cell.photo.image = UIImage(named: firstTable[indexPath.row].storeImage)
//        case 1:
//            cell.name.text = secondTable[indexPath.row].storeName
//            cell.address.text = secondTable[indexPath.row].address
//            cell.workStatus.text = secondTable[indexPath.row].workStatus
//            cell.distance.text = secondTable[indexPath.row].distance
//            cell.time.text = secondTable[indexPath.row].time
//            cell.photo.image = UIImage(named: secondTable[indexPath.row].storeImage)
//        case 2:
//            cell.name.text = thirdTable[indexPath.row].storeName
//            cell.address.text = thirdTable[indexPath.row].address
//            cell.workStatus.text = thirdTable[indexPath.row].workStatus
//            cell.distance.text = thirdTable[indexPath.row].distance
//            cell.time.text = thirdTable[indexPath.row].time
//            cell.photo.image = UIImage(named: thirdTable[indexPath.row].storeImage)
//        default:
//            break;
//        }
        return cell
        
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
