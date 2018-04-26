//
//  SettingViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var SettingTitle = [ [NSLocalizedString("settingColor", comment: ""), NSLocalizedString("settingColor1", comment: ""), NSLocalizedString("settingColor2", comment: ""), NSLocalizedString("settingColor3", comment: ""), NSLocalizedString("settingColor4", comment: "")],
                       [NSLocalizedString("settingRemoveAd", comment: ""), NSLocalizedString("settingPurchase", comment: "")],
                       [NSLocalizedString("settingSupport", comment: ""), "Twitter", NSLocalizedString("settingSupport2", comment: "")]
    ]
    
    var SettingSubtitle = [ ["", NSLocalizedString("settingColor1E", comment: ""), NSLocalizedString("settingColor2E", comment: ""), NSLocalizedString("settingColor3E", comment: ""), NSLocalizedString("settingColor4E", comment: "")],
                          ["", NSLocalizedString("settingPurchaseE", comment: "")],
                          ["", NSLocalizedString("settingSupport1E", comment: ""), NSLocalizedString("settingSupport2E", comment: "")]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - テーブル設定
    //参照：https://qiita.com/Ryosuke-Hujisawa/items/d2dcc260087230345acb
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingTitle[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = SettingTitle[indexPath.section][indexPath.row + 1]
        cell.detailTextLabel?.text = SettingSubtitle[indexPath.section][indexPath.row + 1]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingTitle[section][0]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

}
