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
        super.init()
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
            
            //方位精度
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.headingOrientation = .portrait
            
            //方位と位置の取得開始
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }else{
            isAllowGPS = false
        }
        
    }
    
    //GPS取得
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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

    
    //過去データから取得
    public func getPastData() {
        //ローカル変数に履歴の配列を格納
        var historyArray = AppDelegate.memory!.getUserDefaults()
        
        if historyArray.isEmpty {
            print("履歴が存在しません")
        } else {
            print("履歴を読み取りました")
            
            //一番最新の履歴を読み取り
            let tmpDic = historyArray[0]
            //最新の履歴をメンバ変数に格納
            self.recordedLatitude = tmpDic["latitude"] as! CLLocationDegrees
            self.recordedLongitude = tmpDic["longitude"] as! CLLocationDegrees
            
            print("記録されていた座標＝＞緯度：\(self.recordedLatitude)経度：\(self.recordedLongitude)")
        }
    }
    
    //距離計算
    public func calcDistance() -> (distance: Double, angle: Double) {
        var resultDistance: Double = 0
        var resultAngle: Double = 0
        
        let tmpLat = self.recordedLatitude - self.nowLatitude
        let tmpLon = self.recordedLongitude - self.nowLongitude
        
        let SILat = convertSI(coordinate: tmpLat, mode: 0)
        let SILon = convertSI(coordinate: tmpLon, mode: 1)
        
        resultDistance = sqrt(pow(abs(SILat),2)+pow(abs(SILon),2))
        resultAngle = methodClass.toDegree(radian: atan2(SILon, SILat)) - self.nowAngle
        resultAngle = methodClass.toRadian(degree: resultAngle)
        return (resultDistance, resultAngle)
    }
    
    private func convertSI(coordinate: Double, mode: Int) -> Double {
        var tmpDistance = coordinate * correctionFactor(mode: mode)
        if mode == 1 {
            //赤道外補正
            let tmpLat = self.recordedLatitude + self.nowLatitude
            let absAngle = abs(tmpLat/2)
            let radianAngle = methodClass.toRadian(degree: absAngle)
            tmpDistance *= cos(radianAngle)
        }
        return tmpDistance
    }
    
    private func correctionFactor(mode: Int) -> Double {
        //http://blog.netandfield.com/shar/2014/04/post-1789.html
        if mode == 0 {
            //緯度　極半径=>直径=>m換算=>1度あたりの距離
            return 6356.752 * 2 * 3.1415 * 1000 / 360
        } else {
            //経度　赤道半径=>直径=>m換算=>1度あたりの距離
            return 6378.137 * 2 * 3.1415 * 1000 / 360
        }
    }
    
    //現在地を記録
    public func recordNowCoordinates() {
        self.recordedLatitude = self.nowLatitude
        self.recordedLongitude = self.nowLongitude
    }
    
    //指定地を記録
    public func recordDesignationCoodinates(latitude: AnyObject, longitude: AnyObject) {
        self.recordedLatitude = latitude as! CLLocationDegrees
        self.recordedLongitude = longitude as! CLLocationDegrees
    }
    
}
