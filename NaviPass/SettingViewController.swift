//
//  SettingViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingTable: UITableView!
    
    var SettingTitle = [ [NSLocalizedString("settingColor", comment: ""), NSLocalizedString("settingColor1", comment: ""), NSLocalizedString("settingColor2", comment: ""), NSLocalizedString("settingColor3", comment: ""), NSLocalizedString("settingColor4", comment: "")],
                       [NSLocalizedString("settingRemoveAd", comment: ""), NSLocalizedString("settingPurchase", comment: "")],
                       [NSLocalizedString("settingSupport", comment: ""), "Twitter", NSLocalizedString("settingSupport2", comment: "")]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //色設定保持
        if indexPath.row <= 3 && indexPath.section == 0 {
            if indexPath.row != AppDelegate.memory?.getSettingData() {
                AppDelegate.memory?.setSettingData(settingNumber: indexPath.row)
                settingTable.reloadData()
            }
        }
        
        //サポート
        if indexPath.row <= 1 && indexPath.section == 2 {
            if indexPath.row == 0 {
                openTwitter()
            } else {
                openBrowser()
            }
        }
    }
    
    //MARK: - サポート
    //Twitterアプリを開く
    private func openTwitter() {
        if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
            print("Twitter インストール済み")
        } else {
            print("Twitter インストールされていない")
        }
    }
    
    //ウエブページを開く
    private func openBrowser() {
        
    }
    
    

}
