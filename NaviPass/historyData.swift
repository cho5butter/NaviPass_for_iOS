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
    private var historyData: Array<Dictionary<String, AnyObject>>!
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
            self.historyData = UserDefaults.standard.array(forKey: "historyArr") as! Array<Dictionary>
        } else {
            //存在していなかった時
            //空の配列を格納
            print(logStr + "過去データが存在しなかったため、空の配列を代入しました")
            self.historyData = []
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
    public func getUserDefaults() -> Array<Dictionary<String, AnyObject>>{
        //現在の履歴を取り出す
        return self.historyData
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
    
    //現在地の記録
    public func saveNowPoint() {
        AppDelegate.time?.recordNowData() //記録時間を今の時間に書き換えるよ
        AppDelegate.coodinate?.recordNowCoordinates() //記録座標を今の座標に切り替えるのじゃー！！世知辛くない
        let tmpData = AppDelegate.time?.getNowData()
        let tmpLat = AppDelegate.coodinate?.getLatitude()
        let tmpLon = AppDelegate.coodinate?.getLongitude()
        let tmpDic: Dictionary = ["latitude": tmpLat as Any, "longitude": tmpLon as Any, "time": tmpData as Any] as [String : AnyObject]
        self.historyData.insert(tmpDic, at: 0) //配列の最初に現在地点を記録した辞書を追加
        removePastData()
        UserDefaults.standard.set(self.historyData, forKey: "historyArr")
        
    }
    
    //過去データの記録
    public func setOldPoint(num: Int) {
        let tmpDic = self.historyData[num]
        AppDelegate.coodinate?.recordDesignationCoodinates(latitude: tmpDic["latitude"]!, longitude: tmpDic["longitude"]!)
        AppDelegate.time?.recordDesignationTime(time: tmpDic["time"] as! Date)
        let newDic: Dictionary = ["latitude": tmpDic["latitude"], "longitude": tmpDic["longitude"], "time": tmpDic["time"]]
        self.historyData.insert(newDic as [String : AnyObject], at: 0)
        removePastData()
        UserDefaults.standard.set(self.historyData, forKey: "historyArr")
    }
    
    private func removePastData() {
        if self.historyData.count >= 10 {
            print("履歴が11以上存在しているため、超過分を削除しました")
            self.historyData.remove(at: 10)
        } else {
            print("超過をしていないため、削除されませんでした")
        }
    }
    
    
}
