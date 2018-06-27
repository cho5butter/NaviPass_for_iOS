//
//  ViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import PopupDialog

class ViewController: UIViewController {

    @IBOutlet weak var arrowImg: UIImageView! //マップ画像
    @IBOutlet weak var mapImg: UIImageView! //矢印画像
    @IBOutlet weak var mainLabel: UILabel! //距離表示ラベル
    @IBOutlet weak var subLabel: UILabel! //記録時刻表示ラベル
    @IBOutlet weak var recordButton: UIButton! //現在地記録ボタン
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        Timer.scheduledTimer(timeInterval: 10/1000, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.layoutSetup()
        print("viewWillAppear")
        AppDelegate.layoutSetup()
        
    }
    
    //MARK: - レイアウト
    public func layoutSetup() {
        backgroundColor()
        iconTheme()
        navigationItem.backBarButtonItem?.title = NSLocalizedString("backButton", comment: "")
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
    
    //MARK: - ボタンタップ処理
    @IBAction func recordButton(_ sender: Any) {
        if (AppDelegate.coodinate?.getLatitude()) != nil {
            AppDelegate.memory?.saveNowPoint()
        } else {
            self.showPopup()
        }
    }
    
    //MARK: - タイマー
    @objc func timerUpdate () {
        if !(AppDelegate.memory?.getUserDefaults().isEmpty)!{
            updateDistanceLabel()
            updateTimeLabel()
        }
    }
    
    private func updateDistanceLabel() {
        let tmpInfo = AppDelegate.coodinate?.calcDistance()
        let tmpDistance = Int((tmpInfo?.distance)!)
        mainLabel.text = String(tmpDistance)
        rotateArrowImage(angle: (tmpInfo?.angle)!)
    }
    
    private func updateTimeLabel() {
        
    }
    
    private func rotateArrowImage(angle: Double) {
        arrowImg.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    //MARK: - ポップアップ
    
    private func showPopup() {
        let popup = PopupDialog(title:NSLocalizedString("mainAlertTitle", comment: ""), message:NSLocalizedString("mainAlertMessage", comment: ""))
        let button = CancelButton(title: "CLOSE") {
        }
        popup.addButton(button)
        present(popup, animated: true, completion: nil)
    }
    
}

