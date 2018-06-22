//
//  coodinateData.swift
//  
//
//  Created by cho5butter on 2018/06/22.
//

import UIKit
import CoreLocation

class coodinateData: NSObject, CLLocationManagerDelegate {
    
    //位置管理 https://qiita.com/chino_tweet/items/db3a536234a43a3c31d9
    var locationManager: CLLocationManager!
    //GPSが許可されているか
    var isAllowGPS: Bool!
    //記録情報
    var recordedLatitude: CLLocationDegrees! //緯度
    var recordedLongitude: CLLocationDegrees! //経度
    //現在
    var nowLatitude: CLLocationDegrees! //緯度
    var nowLongitude: CLLocationDegrees! //経度
    var nowAngle: CLLocationDirection! //角度
    
    //イニシャライズ
    override init(){
        self.setUpLocationManager()
        
    }
    
    //GPS初期処理
    public func setUpLocationManager() {
        //初期化
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        
        //起動時のみGPSの取得を許可
        locationManager.requestWhenInUseAuthorization()
        
        //許可された場合のみ
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            isAllowGPS = true
            
            locationManager.delegate = self
            
            //GPS精度
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.activityType = .fitness
            
            //方位と位置の取得開始
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingLocation()
        }else{
            isAllowGPS = false
        }
        
    }
    
    //GPS取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("GPS取得が実行されています")
        for location in locations {
            self.nowLatitude = location.coordinate.latitude
            self.nowLongitude = location.coordinate.longitude
        }
    }
    
    //角度取得
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.nowAngle = newHeading.magneticHeading
    }
    
    //緯度取得
    public func getLatitude() -> CLLocationDegrees {
        return self.nowLatitude
    }
    
    //経度取得
    public func getLongitude() -> CLLocationDegrees {
        return self.nowLongitude
    }
    
    //角度取得
    public func getAngle() -> CLLocationDirection {
        return self.nowAngle
    }
    

}
