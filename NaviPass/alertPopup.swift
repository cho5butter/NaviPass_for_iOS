//
//  alertPopup.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import PopupDialog //https://cocoapods.org/pods/PopupDialog


class alertPopup: NSObject {
    private var themeSetting: Int!
    
    override init() {
        super.init()
        self.decideThemeColor()
        
    }
    
    private func decideThemeColor() {
        let setting = AppDelegate.memory?.getSettingData()
        
        if setting! <= 1 {
            self.themeSetting = 0; //blcakTheme
        } else {
            self.themeSetting = 1; //blackTheme
        }
    }
    
    public func dialog(title: String, message: String) {
        let popup = PopupDialogDefaultView.appearance()
        popup.titleFont = UIFont(name: "HelveticaNeue-Light", size: 16)!
        popup.messageFont = UIFont(name: "HelveticaNeue", size: 14)!
        if self.themeSetting == 0 {
            popup.titleColor = UIColor.white
            popup.messageColor = UIColor(white: 0.8, alpha: 1)
        } else {
            popup.titleColor = UIColor.black
            popup.messageColor = UIColor(white: 0.2, alpha: 1)
        }
    }

}
