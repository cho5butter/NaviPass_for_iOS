//
//  timeClass.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/26.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class timeClass: UIViewController {
    
    private var recordedDate: NSDate!
    
    public func getPastData() {
        //ローカル変数に履歴の配列を格納
        var historyArray = AppDelegate.memory!.getUserDefaults()
        if historyArray.isEmpty {
            print("履歴が存在しません")
        } else {
            print("履歴を読み取りました")
            let tmpDic = historyArray[0]
            let tmpArr = Array(tmpDic.allValues)
            self.recordedDate = tmpArr[3] as! NSDate
            
            print("記録されていた時間=>\(self.recordedDate)")
        }
    }
    
    public func calcElapsedTime() -> Double {
        let elapsedTime = self.recordedDate.timeIntervalSinceNow
        
        return elapsedTime
    }

}
