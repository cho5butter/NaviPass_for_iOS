//
//  MapViewController.swift
//  NaviPass
//
//  Created by cho5butter on 2018/06/30.
//  Copyright © 2018年 ちょこばた. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    //マップ
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayGoogleMap()
    }
    
    private func displayGoogleMap() {
        //初期位置設定
        let camera = self.getInitCamera()
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView.isMyLocationEnabled = true
        self.mapView.isIndoorEnabled = true
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        view = self.mapView
        
        //マーカー
        if !(AppDelegate.memory?.getUserDefaults().isEmpty)! {
            let tmpArr = AppDelegate.memory?.getUserDefaults()
            let tmpDic = tmpArr![0]
            let position = CLLocationCoordinate2D(latitude: tmpDic["latitude"] as! CLLocationDegrees, longitude: tmpDic["longitude"] as! CLLocationDegrees)
            let marker = GMSMarker(position: position)
            marker.title = NSLocalizedString("mapPinTitle", comment: "")
            marker.snippet = NSLocalizedString("mapPinSnipet", comment: "")
            marker.icon = GMSMarker.markerImage(with: AppDelegate.color?.getButtonColor())
            marker.map = mapView
        }
    }
    
    private func getInitCamera() -> GMSCameraPosition {
        var latitude: CLLocationDegrees! = 34.68
        var longitude: CLLocationDegrees! = 135.84
        if AppDelegate.coodinate?.getLongitude() != nil {
            latitude = AppDelegate.coodinate?.getLatitude()
            longitude = AppDelegate.coodinate?.getLongitude()
        }
        return GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
    }
    


}
