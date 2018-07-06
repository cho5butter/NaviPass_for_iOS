//
//  methodClass.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/24.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class methodClass: UIViewController {
    //MARK: - 外部アプリオープン
    static public func openTwitter(twitterId: String) {
        //Twitterアプリがあるかの確認
        if UIApplication.shared.canOpenURL(URL(string: "twitter://")!) {
            print("Twitter インストール済み")
            let tUrl = URL(string: "twitter://user?id=" + twitterId)!
            UIApplication.shared.open(tUrl, options: [:], completionHandler: nil)
        } else {
            print("Twitter インストールされていない")
            let tUrl = "twitter.com/intent/user?user_id=" + twitterId
            methodClass.openBrowser(url: tUrl)
        }
    }
    
    static public func openBrowser(url: String) {
        //Chromeがあるかの確認
        if UIApplication.shared.canOpenURL(URL(string: "googlechrome://")!) {
            print("Chrome インストール済み")
            let wUrl = URL(string: "googlechromes://" + url)!
            UIApplication.shared.open(wUrl, options: [:], completionHandler: nil)
        } else {
            print("Chrome インストールされていない")
            let wUrl = URL(string: "https://" + url)!
            UIApplication.shared.open(wUrl, options: [:], completionHandler: nil)
        }
    }
    //MARK: - rad degree 換算
    static public func toRadian(degree: Double) -> Double {
        return degree * Double.pi / 180
    }
    
    static public func toDegree(radian: Double) -> Double {
        return radian * 180 / Double.pi
    }

}
