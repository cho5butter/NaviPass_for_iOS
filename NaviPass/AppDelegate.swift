//
//  AppDelegate.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var memory: historyData? //記録クラスインスタンス
    static var coodinate: coodinateData? //座標クラスインスタンス
    static var time: timeClass? //時間クラスインスタンス
    static var color: themeColor? //色クラスインスタンス

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GoogleAPIInitialize()
        AppDelegate.memory = historyData() //記録クラスインスタンス化
        AppDelegate.coodinate = coodinateData() //座標取得クラスインスタンス化
        AppDelegate.time = timeClass() //時間クラスをインスタンス化
        AppDelegate.color = themeColor() //色クラスをインスタンス化
        AppDelegate.coodinate?.getPastData() //過去データ取得
        AppDelegate.time?.getPastData() //過去時間取得
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func GoogleAPIInitialize() {
        //GoogleサービスAPI設定
        GMSServices.provideAPIKey("AIzaSyA0JJOTB19DiJF-FonrdBUwb0609Gz4bIw")
    }
}

