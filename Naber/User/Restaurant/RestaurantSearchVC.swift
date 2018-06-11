//
//  RestaurantSearchViewController.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/26.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit



class RestaurantSearchVC: UIViewController{

    var firstTable = [StoreInfoClass]()
    var secondTable = [StoreInfoClass]()
    var thirdTable = [StoreInfoClass]()
    
    var typesArray = ["早餐", "早午餐", "午餐", "下午茶", "晚餐","宵夜"]
    
    var areasArray = ["台北", "桃園", "台中", "台南", "高雄"]
    
    var distancesArray = ["0~100M", "101~200M", "201~300M", "301~400M", "401~500M"]
    
    
    var oldSelectSubOptionValue = 0;
    
    @IBOutlet weak var selectSubOption: UILabel!
    
    @IBOutlet weak var segmentedChoose: UISegmentedControl!
    
    @IBOutlet weak var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.restaurantTableView.dataSource = self
        self.restaurantTableView.delegate = self
        
        initialFirstTable()
        initialSecondTable()
        initialThridTable()
        // Do any additional setup after loading the view.
    }
    @IBAction func switchTheTableViewBySegmentControl(_ sender: AnyObject) {
        bottomAlert( sender )
    }
    
    func initialFirstTable(){
        let storeInfo = StoreInfoClass()
        storeInfo.storeName="Berkeley Cafe"
        storeInfo.workStatus="Cosy"
        storeInfo.distance="100M";
        storeInfo.time="AM08:00~PM10:00";
        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
        storeInfo.storeImage="berkeleyCafe";
        firstTable.append(storeInfo)
        firstTable.append(storeInfo)
        firstTable.append(storeInfo)

    }
    func initialSecondTable(){
        let storeInfo = StoreInfoClass()
        storeInfo.storeName="Berkeley Cafe"
        storeInfo.workStatus="Cosy"
        storeInfo.distance="100M";
        storeInfo.time="AM08:00~PM10:00";
        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
        storeInfo.storeImage="berkeleyCafe";
        secondTable.append(storeInfo)

    }
    func initialThridTable(){
        let storeInfo = StoreInfoClass()
        storeInfo.storeName="Berkeley Cafe"
        storeInfo.workStatus="Cosy"
        storeInfo.distance="100M";
        storeInfo.time="AM08:00~PM10:00";
        storeInfo.address="桃園市桃園區中山路100號桃園市桃園區中山路100號桃園市桃園區中山路100號"
        storeInfo.storeImage="berkeleyCafe";
        thirdTable.append(storeInfo)
        thirdTable.append(storeInfo)
        thirdTable.append(storeInfo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (segmentedChoose.selectedSegmentIndex){
        case 0:
            returnValue = firstTable.count
        case 1:
            returnValue = secondTable.count
        case 2:
            returnValue = thirdTable.count
        default:
            break;
        }
        return returnValue

    }
    
    
    func bottomAlert(_ sender: AnyObject ) {
        switch (segmentedChoose.selectedSegmentIndex){
            case 0:
                let sheet = addSheetClassForSwitchPopupAlert(dataArray: typesArray, sender: AnyObject.self as AnyObject )
                present(sheet, animated: true, completion: nil)
            case 1:
                let sheet = addSheetClassForSwitchPopupAlert(dataArray: areasArray, sender: AnyObject.self as AnyObject )
                present(sheet, animated: true, completion: nil)
            case 2:
                self.oldSelectSubOptionValue = self.segmentedChoose.selectedSegmentIndex;
                self.selectSubOption.text = "距離"
                self.restaurantTableView.reloadData()
            default:
                break;
        }
        
    }
    
    func addSheetClassForSwitchPopupAlert (dataArray : Array<String> , sender: AnyObject ) -> UIAlertController{
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
                self.restaurantTableView.reloadData()
            }
            sheet.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel ) { (action) in
            self.segmentedChoose.selectedSegmentIndex=self.oldSelectSubOptionValue;
        }
        sheet.addAction(cancel)
        
        return sheet
        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RestaurantStoreInfoVC
        {
            let vc = segue.destination as? RestaurantStoreInfoVC
            vc?.username = "Arthur Dent"
        }
    }
    

}

extension RestaurantSearchVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (segmentedChoose.selectedSegmentIndex){
        case 0:
            print("You selected cell #\(firstTable[indexPath.row].storeName)!")
            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
        //            navigationController?.pushViewController(destination, animated: true)
        case 1:
            print("You selected cell #\(secondTable[indexPath.row].storeName)!")
            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
        //            navigationController?.pushViewController(destination, animated: true)
        case 2:
            print("You selected cell #\(thirdTable[indexPath.row].storeName)!")
            //            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //            let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! YourViewController
        //            navigationController?.pushViewController(destination, animated: true)
        default:
            break;
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextController = storyboard.instantiateViewController(withIdentifier: "RestaurantStoreInfo") as! RestaurantStoreInfoViewController
//        nextController.storeName.text = "Taylor Swift"
//        self.navigationController?.pushViewController(nextController, animated: true)

        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTVCell
        switch (segmentedChoose.selectedSegmentIndex){
        case 0:
            cell.storeName.text = firstTable[indexPath.row].storeName
            cell.address.text = firstTable[indexPath.row].address
            cell.workStatus.text = firstTable[indexPath.row].workStatus
            cell.distance.text = firstTable[indexPath.row].distance
            cell.time.text = firstTable[indexPath.row].time
            cell.thumbnailImageView.image = UIImage(named: firstTable[indexPath.row].storeImage)
        case 1:
            cell.storeName.text = secondTable[indexPath.row].storeName
            cell.address.text = secondTable[indexPath.row].address
            cell.workStatus.text = secondTable[indexPath.row].workStatus
            cell.distance.text = secondTable[indexPath.row].distance
            cell.time.text = secondTable[indexPath.row].time
            cell.thumbnailImageView.image = UIImage(named: secondTable[indexPath.row].storeImage)
        case 2:
            cell.storeName.text = thirdTable[indexPath.row].storeName
            cell.address.text = thirdTable[indexPath.row].address
            cell.workStatus.text = thirdTable[indexPath.row].workStatus
            cell.distance.text = thirdTable[indexPath.row].distance
            cell.time.text = thirdTable[indexPath.row].time
            cell.thumbnailImageView.image = UIImage(named: thirdTable[indexPath.row].storeImage)
        default:
            break;
        }
        return cell
        
    }
}
