//
//  SettingViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import PopupDialog

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingTable: UITableView!
    
    var SettingTitle = [ [NSLocalizedString("settingColor", comment: ""), NSLocalizedString("settingColor1", comment: ""), NSLocalizedString("settingColor2", comment: ""), NSLocalizedString("settingColor3", comment: ""), NSLocalizedString("settingColor4", comment: "")],
                       [NSLocalizedString("settingRemoveAd", comment: ""), NSLocalizedString("settingPurchase", comment: "")],
                       [NSLocalizedString("settingSupport", comment: ""), "Twitter", NSLocalizedString("settingSupport2", comment: "")], ["Info", "version", "license"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupNavigationColor()
    }
    
    private func setupNavigationColor() {
        //ナビゲーションバーの色変更
        self.navigationController?.navigationBar.barTintColor = AppDelegate.color?.getNavigationColor()
        //ナビゲーションアイコンの色変更
        self.navigationController?.navigationBar.tintColor = AppDelegate.color?.getNavigationIconColor()
        //タイトル色変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : AppDelegate.color?.getNavigationTitleColor() ?? UIColor.white]
    }
    
    // MARK: - テーブル設定
    //参照：https://qiita.com/Ryosuke-Hujisawa/items/d2dcc260087230345acb
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingTitle.count
    }
    //セルの個数（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingTitle[section].count - 1
    }
    //セルに値を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = SettingTitle[indexPath.section][indexPath.row + 1]
        if indexPath.section == 3 && indexPath.row == 0 {
            cell.detailTextLabel?.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        }
        
        //現在設定されている色は選択不可能にする
        if indexPath.row == AppDelegate.memory?.getSettingData() && indexPath.section == 0 {
            cell.selectionStyle = .none
            cell.backgroundColor = .lightGray
        } else {
            cell.selectionStyle = .default
        }
        
        return cell
    }
    //タイトルをつけるメソッド
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingTitle[section][0]
    }
    //選択された時に呼び出されるメソッド（必須）
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("indexPath.row:\(indexPath.row), indexPath.section:\(indexPath.section)")
        if indexPath.section == 0 {
            //色設定
            if indexPath.row != AppDelegate.memory?.getSettingData() {
                AppDelegate.memory?.setSettingData(settingNumber: indexPath.row)
                settingTable.reloadData()
                AppDelegate.color?.reloadColor()
                self.setupNavigationColor()
            }
        } else if indexPath.section == 1 {
            //課金設定
            let popup = PopupDialog(title:NSLocalizedString("settingAlertTitle", comment: ""), message:NSLocalizedString("settingAlertMessage", comment: ""))
            let button = CancelButton(title: "CLOSE") {
            }
            popup.addButton(button)
            present(popup, animated: true, completion: nil)
        } else if indexPath.section == 2 {
            //サポート設定
            if indexPath.row == 0 {
                methodClass.openTwitter(twitterId: "152635614")
            } else {
                methodClass.openBrowser(url: "c5bt.net/contact")
            }
            
        } else {
            if indexPath.row == 0 {
            } else {
                let url = URL(string: "app-settings:root=General&path=net.c5bt.NaviPass")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    

}
