//
//  ViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var arrowImg: UIImageView! //マップ画像
    @IBOutlet weak var mapImg: UIImageView! //矢印画像
    @IBOutlet weak var mainLabel: UILabel! //距離表示ラベル
    @IBOutlet weak var subLabel: UILabel! //記録時刻表示ラベル
    @IBOutlet weak var recordButton: UIButton! //現在地記録ボタン
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - レイアウト
    private func layoutSetup() {
        backgroundColor()
        iconTheme()
    }
    
    
    private func backgroundColor() {
        //背景色
        switch AppDelegate.memory?.getSettingData() {
        case 0:
            self.view.backgroundColor = UIColor(red: 66/255, green: 169/255, blue: 206/255, alpha: 1.0)
        default:
            break
        }
    }
    
    private func iconTheme() {
        //テーマごとの画像
        switch AppDelegate.memory?.getSettingData() {
        case 0:
            arrowImg.image = UIImage(named: "arrowImg") //矢印画像
            mapImg.image = UIImage(named: "map icon") //マップアイコン
            mainLabel.textColor = UIColor.white //距離ラベル文字色
            subLabel.textColor = UIColor.white //テキストラベル文字色
            subLabel.adjustsFontSizeToFitWidth = true //文字サイズ自動調整
            recordButton.backgroundColor = UIColor(red: 121/255, green:68/255, blue:146/255, alpha: 1.0) //ボタン背景色
            recordButton.setTitleColor(UIColor.white, for: .normal) //ボタン文字色
        default:
            break
        }
    }


}

