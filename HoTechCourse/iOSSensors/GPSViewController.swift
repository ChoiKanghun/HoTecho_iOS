//
//  GPSViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/03.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController  {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var administrativeAreaLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var subLocalityLabel: UILabel!
    @IBOutlet weak var distanceFromGangnamStationLabel: UILabel!
    @IBOutlet weak var compassLabel: UILabel!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLHeadingFilterNone
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.startUpdatingLocation()
        
        requestGPSPermission()
    }
    
    func requestGPSPermission(){
        locationManager.requestWhenInUseAuthorization()

        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinate = locationManager.location?.coordinate
            else {return}
            latitudeLabel?.text = "\(coordinate.latitude)"
            longtitudeLabel?.text = "\(coordinate.longitude)"
        case .restricted, .notDetermined:
            DispatchQueue.main.async {
                self.requestGPSPermission()
            }
        case .denied:
            print("GPS: 권한 없음")
        default:
            print("GPS: Default")
        }
    }
}

extension GPSViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.locationManager.startUpdatingHeading()

        
        // the most recent location update is at the end of the array.
        let location: CLLocation = locations[locations.count - 1]
        let longtitude: CLLocationDegrees = location.coordinate.longitude
        let latitude:CLLocationDegrees = location.coordinate.latitude
        
        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") //korea
            
        geoCoder.reverseGeocodeLocation(location, preferredLocale: local) {
            (place, error) in
            if let address: [CLPlacemark] = place {
                self.latitudeLabel?.text = "\(latitude)"
                self.longtitudeLabel?.text = "\(longtitude)"
                self.administrativeAreaLabel?.text =
                    address.last?.administrativeArea
                self.localityLabel?.text =
                    address.last?.locality
                self.subLocalityLabel?.text
                    = address.last?.subLocality
                
                // 바라보는 방향(방위)
                guard let heading = self.locationManager.heading?.trueHeading.binade
                else {return}
                
                if(heading > 23 && heading <= 67) {
                    self.compassLabel?.text = "북동" + "쪽";
                } else if(heading > 68 && heading <= 112){
                    self.compassLabel?.text = "동" + "쪽";
                } else if(heading > 113 && heading <= 167){
                    self.compassLabel?.text = "남동" + "쪽";
                } else if(heading > 168 && heading <= 202){
                    self.compassLabel?.text = "남" + "쪽";
                } else if(heading > 203 && heading <= 247){
                    self.compassLabel?.text = "남서" + "쪽";
                } else if(heading > 248 && heading <= 293){
                    self.compassLabel?.text = "서" + "쪽";
                } else if(heading > 294 && heading <= 337){
                    self.compassLabel?.text = "북서" + "쪽";
                } else if(heading >= 338 || heading <= 22){
                    self.compassLabel?.text = "북" + "쪽";
                }
                
//                print("name:\(address.last?.name)")
//                print("isoCountryCode: \(address.last?.isoCountryCode)")
//                print("country: \(address.last?.country)")
//                print("postalCode: \(address.last?.postalCode)")
//                print("administrativeArea: \(address.last?.administrativeArea)")
//                print("subAdministrativeArea:\(address.last?.subAdministrativeArea)")
//                print("locality: \(address.last?.locality)")
//                print("subLocality: \(address.last?.subLocality)")
//                print("thoroughfare: \(address.last?.thoroughfare)")
//                print("subThoroughfare: \(address.last?.subThoroughfare)")
//                print("region:\(address.last?.region)")
//                print("timeZone: \(address.last?.timeZone)")
//
//
                let locationGangnam = CLLocation(latitude: 37.4968985, longitude: 127.0298547)
                let distanceFromGangnamStation = locationGangnam.distance(from: location)
                self.distanceFromGangnamStationLabel?.text = "\(distanceFromGangnamStation / 1000)"
                
            }
        }
    }
}
