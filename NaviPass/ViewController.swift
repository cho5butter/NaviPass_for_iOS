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
        self.layoutSetup()
        Timer.scheduledTimer(timeInterval: 10/1000, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.layoutSetup()
    }
    
    //MARK: - レイアウト
    public func layoutSetup() {
        self.backgroundColor()
        self.iconTheme()
        navigationItem.backBarButtonItem?.title = NSLocalizedString("backButton", comment: "")
        self.setupNavigationColor()
    }
    
    private func setupNavigationColor() {
        //ナビゲーションバーの色変更
        self.navigationController?.navigationBar.barTintColor = AppDelegate.color?.getNavigationColor()
        //ナビゲーションアイコンの色変更
        self.navigationController?.navigationBar.tintColor = AppDelegate.color?.getNavigationIconColor()
        //タイトル色変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : AppDelegate.color?.getNavigationTitleColor() ?? UIColor.white]
    }
    
    private func backgroundColor() {
        //背景色
        self.view.backgroundColor = AppDelegate.color?.getBackgroundColor()
    }
    
    private func iconTheme() {
        let mapImgName: Array<String>  = ["arrowImg","arrowImgCool","arrowImgCute","arrowImgLight"] //テーマごとの矢印画像の名前配列
        arrowImg.image = UIImage(named: mapImgName[(AppDelegate.memory?.getSettingData())!]) //矢印画像
        mapImg.image = UIImage(named: "map icon") //マップアイコン
        mainLabel.textColor = AppDelegate.color?.getMainLabelColor() //距離ラベル文字色
        subLabel.textColor = AppDelegate.color?.getSubLabelColor()  //テキストラベル文字色
        subLabel.adjustsFontSizeToFitWidth = true //文字サイズ自動調整
        recordButton.backgroundColor = AppDelegate.color?.getButtonColor() //ボタン背景色
        recordButton.setTitleColor(AppDelegate.color?.getButtonLabelColor(), for: .normal) //ボタン文字色
    }
    
    //MARK: - ボタンタップ処理
    @IBAction func recordButton(_ sender: Any) {
        if (AppDelegate.coodinate?.nowLatitude) != nil && (AppDelegate.coodinate?.nowAngle) != nil {
            AppDelegate.memory?.saveNowPoint()
        } else {
            self.showPopup(title: NSLocalizedString("mainAlertTitle", comment: ""), content: NSLocalizedString("mainAlertMessage", comment: ""))
        }
    }
    
    //MARK: - タイマー
    @objc func timerUpdate () {
        if !(AppDelegate.memory?.getUserDefaults().isEmpty)! && AppDelegate.coodinate?.nowAngle != nil && AppDelegate.coodinate?.nowLongitude != nil{
            updateDistanceLabel()
            updateTimeLabel()
        }
    }
    
    private func updateDistanceLabel() {
        let tmpInfo = AppDelegate.coodinate?.calcDistance()
        let tmpDistance = Int((tmpInfo?.distance)!)
        mainLabel.text = String(tmpDistance) + "m"
        rotateArrowImage(angle: (tmpInfo?.angle)!)
    }
    
    private func updateTimeLabel() {
        let tmpTime = AppDelegate.time?.calcElapsedTime()
        let tmpElap = tmpTime?.elapsedTime
        let tmpRec = tmpTime?.recordedTime
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EE MM d", options: 0, locale: NSLocale.current)
        let strTime = timeFormatter.string(from: tmpRec!)
        let elapFormatter = DateComponentsFormatter()
        elapFormatter.unitsStyle = .full
        elapFormatter.allowedUnits = [.year, .hour, .minute]
        let strElap = elapFormatter.string(from: tmpElap!)
        subLabel.text = strElap! + "(" + strTime + ")"
    }
    
    private func rotateArrowImage(angle: Double) {
        arrowImg.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    //MARK: - ポップアップ
    
    private func showPopup(title: String, content: String) {
        let popup = PopupDialog(title: title, message: content)
        let button = CancelButton(title: "CLOSE") {
        }
        popup.addButton(button)
        present(popup, animated: true, completion: nil)
    }
    
}

