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
    private var defaults: UserDefaults!
    //情報格納
    private var historyDatas: Array<NSDictionary>!
    //設定データ
    private var settingData: Int!
    //ログ用識別
    private var logStr = "Class: historyData　"
    
    override init() {
        super.init()
        //ユーザーデフォルトインスタンス生成
        defaults = UserDefaults.standard
        
        print(logStr + "ユーザーデフォルトクラスインスタンス")
        //履歴の読み込み格納
        confirmExistenceOfHistory()
        //過去の設定の読み込み格納
        confirmExistenceOfSettingData()
    }
    
    //履歴の読み込み格納
    private func confirmExistenceOfHistory() {
        //過去履歴が存在しているかの確認
        if UserDefaults.standard.object(forKey: "historyArr") != nil {
            //格納
            print(logStr + "過去データが存在したため、メンバ変数に格納しました")
            self.historyDatas = UserDefaults.standard.array(forKey: "historyArr") as! Array<NSDictionary>
        } else {
            //存在していなかった時
            //空の配列を格納
            print(logStr + "過去データが存在しなかったため、空の配列を代入しました")
            self.historyDatas = []
        }
    }
    
    //過去の設定の読み込み
    private func confirmExistenceOfSettingData() {
        //ユーザー設定が存在しているかの確認
        if UserDefaults.standard.object(forKey: "settingData") != nil {
            //格納
            print(logStr + "過去の設定が存在したため、メンバ変数に格納しました")
            self.settingData = UserDefaults.standard.integer(forKey: "settingData")
        } else {
            //初期値を格納
            print(logStr + "過去の設定が存在しなかったため、初期値を代入しました")
            self.settingData = 0
        }
        
    }
    
    //履歴の取得
    public func getUserDefaults() -> Array<NSDictionary>{
        //現在の履歴を取り出す
        return self.historyDatas
    }
    
    //設定の取得
    public func getSettingData() -> Int{
        return self.settingData
    }
    
    //設定の記録
    public func setSettingData(settingNumber: Int) {
        self.settingData = settingNumber
        UserDefaults.standard.set(settingNumber, forKey: "settingData")
    }
}
