//
//  ViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/04/25.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        //背景色
        switch AppDelegate.memory?.getSettingData() {
        case 0:
            self.view.backgroundColor = UIColor(red: 66/255, green: 169/255, blue: 206/255, alpha: 1.0)
        default:
            break
        }
    }
    


}

