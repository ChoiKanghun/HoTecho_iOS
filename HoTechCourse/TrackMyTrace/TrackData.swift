//
//  TrackData.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import Foundation
import RealmSwift

class TrackData: Object {
    @objc dynamic var date: Date? = nil
    let traces = List<Trace>()
    
    convenience init (date: Date?) {
        self.init()
        self.date = date
    }
    
    func appendTrace(trace: Trace) {
        self.traces.append(trace)
    }
    
    func formattedDate() -> String {
        guard let date = self.date
        else {return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return dateFormatter.string(from: date)
    }

}
