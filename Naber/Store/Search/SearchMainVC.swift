//
//  SearchMainVC.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/6/8.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit


class SearchMainData{
    var orderStatus: Int = 0
    var itemNumberAndStatus: String = ""
    var itemList: String = ""
    var memoList: String = ""
    var time: String = ""
    var phone: String = ""
    var name: String = ""
    var money: String = ""
}

class SearchMainVC: UIViewController {
    
    var data = [SearchMainData]()
    
    @IBOutlet weak var searchTable: UITableView!
    
    @IBAction func searchOrder(_ sender: Any) {
        setupData()
        searchTable.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData(){
        let data1 = SearchMainData()
        data1.orderStatus = 1
        data1.itemNumberAndStatus="未處理訂單1"
        data1.itemList="炸雞"+"        "+"x1"+"    "+"$"+"10"
        data1.memoList="請儘快幫我弄好，我等一下來領"
        data1.time="2018-05-00"
        data1.phone="0975666123"
        data1.name="甲甲甲"
        data1.money="10"+"$"
        data.append(data1)
        
        let data2 = SearchMainData()
        data2.orderStatus = 2
        data2.itemNumberAndStatus="製作中訂單1"
        data2.itemList="炸雞"+"        "+"x1"+"    "+"$"+"10"
        data2.memoList="請儘快幫我弄好，我等一下來領"
        data2.time="2018-05-00"
        data2.phone="0975666123"
        data2.name="乙乙乙"
        data2.money="10"+"$"
        data.append(data2)
        
        let data3 = SearchMainData()
        data3.orderStatus = 3
        data3.itemNumberAndStatus="已完成訂單1"
        data3.itemList="炸雞"+"        "+"x1"+"    "+"$"+"10"
        data3.memoList="請儘快幫我弄好，我等一下來領"
        data3.time="2018-05-00"
        data3.phone="0975666123"
        data3.name="丙丙丙"
        data3.money="10"+"$"
        data.append(data3)
        
    }
    
}

extension SearchMainVC : UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchMainTVCell
        
        cell.itemNumberAndStatus.text = data[indexPath.row].itemNumberAndStatus
        cell.itemList.text = data[indexPath.row].itemList
        cell.memoList.text = data[indexPath.row].memoList
        cell.time.text = data[indexPath.row].time
        cell.phone.text = data[indexPath.row].phone
        cell.name.text = data[indexPath.row].name
        cell.money.text = data[indexPath.row].money
        
        switch data[indexPath.row].orderStatus {
        case 1:
            cell.orderStatus.text = "未處理"
            cell.button1.setTitleColor(UIColor.white, for: .normal)
            cell.button2.setTitleColor(UIColor.white, for: .normal)
            cell.button3.setTitleColor(UIColor.white, for: .normal)
            cell.button1.backgroundColor = CustomerUIColor.red
            cell.button2.backgroundColor = CustomerUIColor.lightRed
            cell.button3.backgroundColor = CustomerUIColor.lightYellow
            
            cell.button1.setTitle("取消", for: .normal)
            cell.button2.setTitle("製作中", for: .normal)
            cell.button3.setTitle("可領取", for: .normal)
            
            
        case 2:
            cell.orderStatus.text = "製作中"
            
            cell.button1.setTitleColor(UIColor.white, for: .normal)
            cell.button2.setTitleColor(UIColor.white, for: .normal)
            cell.button3.setTitleColor(UIColor.white, for: .normal)
            
            cell.button1.backgroundColor = CustomerUIColor.red
            cell.button2.backgroundColor = CustomerUIColor.lightYellow
            cell.button3.backgroundColor = CustomerUIColor.lightGreen
            
            cell.button1.setTitle("取消", for: .normal)
            cell.button2.setTitle("可領取", for: .normal)
            cell.button3.setTitle("交易完成", for: .normal)
            
            
            
        case 3:
            cell.orderStatus.text = "可領取"
            
            cell.button1.setTitleColor(UIColor.white, for: .normal)
            cell.button2.setTitleColor(UIColor.white, for: .normal)
            cell.button3.setTitleColor(UIColor.white, for: .normal)
            
            cell.button1.backgroundColor = CustomerUIColor.red
            cell.button2.backgroundColor = CustomerUIColor.red
            cell.button3.backgroundColor = CustomerUIColor.lightGreen
            
            cell.button1.setTitle("取消", for: .normal)
            cell.button2.setTitle("跑單", for: .normal)
            cell.button3.setTitle("交易完成", for: .normal)
            
        default:break
        }
        
        
        
        return cell
    }
    
    
    
    
}
