//
//  HistoryViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import MapKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var historyTableView: UITableView! //履歴テーブル表示
    private var historyArr: Array<Dictionary<String, Any>>! //過去データ格納配列
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHistory()
    }
    
    //MARK: - 初期処理関係
    
    private func getHistory() {
        self.historyArr = AppDelegate.memory?.getUserDefaults()
    }
    
    //MARK: - テーブルビュー表示関係
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数
        if self.historyArr.isEmpty {
            return 1
        } else {
            return historyArr.count - 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルの中身
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let numberLabel = cell?.viewWithTag(1) as! UILabel
        let addressLabel = cell?.viewWithTag(2) as! UILabel
        let timeLabel = cell?.viewWithTag(3) as! UILabel
        
        if self.historyArr.isEmpty {
            numberLabel.text = "0"
            addressLabel.text = NSLocalizedString("historyAddressLabel", comment: "")
            timeLabel.text = NSLocalizedString("historyTimeLabel", comment: "")
        } else {
            let tmpDic = self.historyArr[indexPath.row + 1]
            
            numberLabel.text = String(indexPath.row + 1)
            addressLabel.text = self.reverseGeocoder(latitude: tmpDic["latitude"] as! CLLocationDegrees, longitude: tmpDic["longitude"] as! CLLocationDegrees)
            timeLabel.text = self.displayTimeFormat(data: tmpDic["time"] as! Data)
            
        }
        return cell!
    }
    
    //MARK: - 独自関数その他処理
    
    //逆ジオコーディング
    private func reverseGeocoder(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        //インスタンス生成
        let myGeocorder = CLGeocoder()
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        //変数
        var prefecture: String!
        var locality: String!
        var subLocality: String!
        
        //処理
        myGeocorder.reverseGeocodeLocation(myLocation, completionHandler: { (placemarks, error) -> Void in
            for placemark in placemarks! {
                prefecture = placemark.administrativeArea!
                locality = placemark.locality!
                subLocality = placemark.subLocality!
            }
        })
        return prefecture + locality + subLocality
    }
    
    //時間表記整形
    private func displayTimeFormat(data: Data) -> String {
        return "aho"
    }
    
    

}
