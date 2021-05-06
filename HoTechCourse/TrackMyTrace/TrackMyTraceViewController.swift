//
//  TrackMyTraceViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import UIKit
import CoreLocation
import RealmSwift
import MapKit

class TrackMyTraceViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var labelLocationInfo1: UILabel!
    
    var trackData: TrackData = TrackData()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationUsagePermission()
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.MapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        MapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.MapView.setUserTrackingMode(.follow, animated: true)


        self.trackData.date = Date()
    }
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func touchUpShowCurrentLocation(_ sender: Any) {
        // 지도에 내 위치 표시
        MapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.MapView.setUserTrackingMode(.follow, animated: true)
        
    }
    @IBAction func touchUpTrackStopButton(_ sender: Any) {
        self.locationManager.stopUpdatingLocation()
        RealmHelper.shared.create(trackData)
        dismiss(animated: true, completion: nil)
    }
}



extension TrackMyTraceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS 권한 설정됨")
            case .restricted, .notDetermined:
                print("GPS 권한 설정되지 않음")
                DispatchQueue.main.async {
                    self.getLocationUsagePermission()
                }
            case .denied:
                print("GPS 권한 요청 거부됨")
                DispatchQueue.main.async {
                    self.getLocationUsagePermission()
                }
            default:
                print("GPS: Default")
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        guard let latitude = location?.coordinate.latitude
        else {return}
        guard let longtitude = location?.coordinate.longitude
        else {return}
        
        let newTrace = Trace(latitude: latitude, longtitude: longtitude)
        self.trackData.appendTrace(trace: newTrace)
    }
}
