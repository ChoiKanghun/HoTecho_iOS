//
//  Trace.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import Foundation
import RealmSwift

class Trace: Object {
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longtitude: Double = 0
    
    convenience init (latitude: Double, longtitude: Double) {
        self.init()
        self.latitude = latitude
        self.longtitude = longtitude
    }
    
    func latitudeString() -> String? {
        return String(self.latitude)
    }
}
