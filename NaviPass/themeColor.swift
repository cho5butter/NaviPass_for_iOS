//
//  themeColor.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/30.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class themeColor: NSObject {
    //保存色変数
    private var setting: Int!
    
    //標準色決定
    private var defaultColorTheme: Array<UIColor>!
    private var coolColorTheme: Array<UIColor>!
    private var cuteColorTheme: Array<UIColor>!
    private var lightColorTheme: Array<UIColor>!
    
    //各パーツ色決定
    private var mainLabelColor: Array<UIColor>! //メインラベル色
    private var subLabelColor: Array<UIColor>! //サブラベル色
    private var buttonColor: Array<UIColor>! //現在地記録ボタン色
    private var buttonLabelColor: Array<UIColor>! //現在地記録ボタンテキスト色
    private var navigationColor: Array<UIColor>! //ナビゲーション背景色
    private var navigationTitleColor: Array<UIColor>! //ナビゲーションタイトル色
    private var navigationIconColor: Array<UIColor>! //ナビゲーション背景色
    private var backgroundColor: Array<UIColor>! //アプリ背景色
    
    override init() {
        super.init()
        //設定読み込み
        self.getSettingData()
        //標準色 0:背景色 1:ボタン色 2:ナビゲーション色 3:矢印色
        self.defaultColorTheme = [UIColor(red: 66/255, green: 169/255, blue: 206/255, alpha: 1.0), UIColor(red: 121/255, green: 68/255, blue: 148/255, alpha: 1.0), UIColor(red: 232/255, green: 111/255, blue: 40/255, alpha: 1.0), UIColor(red: 248/255, green: 234/255, blue: 51/255, alpha: 1.0)]
        self.coolColorTheme = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0), UIColor(red: 89/255, green: 180/255, blue: 252/255, alpha: 1.0), UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1.0), UIColor(red: 93/255, green: 190/255, blue: 241/255, alpha: 1.0)]
        self.cuteColorTheme = [UIColor(red: 118/255, green: 180/255, blue: 219/255, alpha: 1.0), UIColor(red: 48/255, green: 126/255, blue: 169/255, alpha: 1.0), UIColor(red: 246/255, green: 162/255, blue: 183/255, alpha: 1.0), UIColor(red: 194/255, green: 222/255, blue: 246/255, alpha: 1.0)]
        self.lightColorTheme = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), UIColor(red: 25/255, green: 122/255, blue: 251/255, alpha: 1.0), UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0), UIColor(red: 248/255, green: 234/255, blue: 51/255, alpha: 1.0)]
        
        //各パーツ色
        self.setPartsColor()
    }
    
    public func reloadColor() {
        self.getSettingData()
        self.setPartsColor()
    }
    
    private func getSettingData() {
        self.setting = (AppDelegate.memory?.getSettingData())!
    }
    
    private func setPartsColor() {
        self.mainLabelColor = [UIColor.white, UIColor.black, UIColor.white, UIColor.black]
        self.subLabelColor = [UIColor.white, UIColor.black, UIColor.white, UIColor.black]
        self.buttonColor = [defaultColorTheme[1], coolColorTheme[1], cuteColorTheme[1], lightColorTheme[1]]
        self.buttonLabelColor = [UIColor.white, UIColor.white, UIColor.white, UIColor.white]
        self.navigationColor = [defaultColorTheme[2], coolColorTheme[2], cuteColorTheme[2], lightColorTheme[2]]
        self.navigationTitleColor = [UIColor.white, UIColor.white, UIColor.white, UIColor.black]
        self.navigationIconColor = [UIColor.white, UIColor.white, UIColor.white, lightColorTheme[1]]
        self.backgroundColor = [defaultColorTheme[0], coolColorTheme[0], cuteColorTheme[0], lightColorTheme[0]]
    }
    
    public func getMainLabelColor() -> UIColor {
        return self.mainLabelColor[self.setting]
    }
    
    public func getSubLabelColor() -> UIColor {
        return self.subLabelColor[self.setting]
    }
    
    public func getButtonColor() -> UIColor {
        return self.buttonColor[self.setting]
    }
    
    public func getButtonLabelColor() -> UIColor {
        return self.buttonLabelColor[self.setting]
    }
    
    public func getNavigationColor() -> UIColor {
        return self.navigationColor[self.setting]
    }
    
    public func getNavigationTitleColor() -> UIColor {
        return self.navigationTitleColor[self.setting]
    }
    
    public func getNavigationIconColor() -> UIColor {
        return self.navigationIconColor[self.setting]
    }
    
    public func getBackgroundColor() -> UIColor {
        return self.backgroundColor[self.setting]
    }
    
    

}
