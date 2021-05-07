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
    
    var previousCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationUsagePermission()
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.MapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        MapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.MapView.setUserTrackingMode(.follow, animated: true)
        
        self.MapView.isZoomEnabled = true
        self.MapView.delegate = self
        
        self.trackData.date = Date()
    }
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
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
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
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
        

        guard let location = locations.last
        else {return}
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude

        self.labelLocationInfo1?.text
            = "위도: \(latitude) / 경도: \(longtitude)"
        
        if let previousCoordinate = self.previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.MapView.addOverlay(lineDraw)
        }
        
        self.previousCoordinate = location.coordinate
        
        let newTrace = Trace(latitude: latitude, longtitude: longtitude)
        self.trackData.appendTrace(trace: newTrace)
    }
}

extension TrackMyTraceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0
 
        return renderer
    }
}
