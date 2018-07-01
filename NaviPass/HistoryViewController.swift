//
//  HistoryViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import MapKit
import PopupDialog

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var historyTableView: UITableView! //履歴テーブル表示
    private var historyArr: Array<Dictionary<String, Any>>! //過去データ格納配列
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        if self.historyArr.isEmpty && self.historyArr.count == 1 {
            numberLabel.text = "0"
            addressLabel.text = NSLocalizedString("historyAddressLabel", comment: "")
            timeLabel.text = NSLocalizedString("historyTimeLabel", comment: "")
        } else {
            let tmpDic = self.historyArr[indexPath.row + 1]
            
            numberLabel.text = String(indexPath.row + 1)
            timeLabel.text = self.displayTimeFormat(date: tmpDic["time"] as! Date)
            //インスタンス生成
            let myGeocorder = CLGeocoder()
            let myLocation = CLLocation(latitude: tmpDic["latitude"] as! CLLocationDegrees, longitude: tmpDic["longitude"] as! CLLocationDegrees)
            //処理
            myGeocorder.reverseGeocodeLocation(myLocation, completionHandler: { (placemarks, error) -> Void in
                
                if error != nil {
                    addressLabel.text = "error"
                } else {
                    let placemark = placemarks![0]
                    addressLabel.text = placemark.administrativeArea! + placemark.locality! + placemark.name!
                }
            })
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選択されたときの処理
        tableView.deselectRow(at: indexPath, animated: true)
        if !self.historyArr.isEmpty {
            self.popUpAlert(row: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //データ削除処理
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) -> Void in
            self.historyArr.remove(at: indexPath.row + 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
            AppDelegate.memory?.deleteData(row: indexPath.row + 1)
        }
            deleteButton.backgroundColor = UIColor.red
            return [deleteButton]
    }
    
    //MARK: - 独自関数その他処理
    //履歴呼び出しポップアップ
    private func popUpAlert(row: Int) {
        let popup = PopupDialog(title: NSLocalizedString("historyAlertTitle", comment: ""), message: NSLocalizedString("historyAlertMessage", comment: ""))
        let button1 = DefaultButton(title: NSLocalizedString("historyAlertOK", comment: "")) {
            self.setHistoryLocation(row: row)
            self.navigationController?.popViewController(animated: true)
            print("復元が選択されました")
        }
        let button2 = DefaultButton(title: NSLocalizedString("historyAlertCANCEL", comment: "")) {
            print("処理がキャンセルされました")
        }
        popup.addButtons([button1, button2])
        present(popup, animated: true, completion: nil)
    }
    
    //履歴を目的地に
    private func setHistoryLocation(row: Int) {
        AppDelegate.memory?.setOldPoint(num: row + 1)
    }
    
    //時間表記整形
    private func displayTimeFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EE MM dd HH mm", options: 0, locale: Locale.current)
        return formatter.string(from: date)
    }
    
    

}
