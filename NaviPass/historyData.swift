//
//  historyData.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/22.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class historyData:NSObject {
    
    //ユーザーデフォルトのインスタンス作成
    let defaults = UserDefaults.standard
    //中身があるかの確認
    let isEmpty:Bool!
    //情報格納
    var historyDatas: Array<NSDictionary>!
    
    override init() {
        print("ユーザーデフォルトクラスインスタンス")
        //既に中身が存在するかどうかの確認
        if let historyData = defaults.array(forKey: "historyArr") as? Array<NSDictionary>{
            isEmpty = false
            self.historyDatas = historyData
        } else {
            isEmpty = true
            self.historyDatas = []
        }
    }
    
    public func getUserDefaults() -> Array<NSDictionary>{
        //現在の履歴を取り出す
        return self.historyDatas
    }
}
