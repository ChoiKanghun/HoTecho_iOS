//
//  PickupLines.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/03.
//

import Foundation
import RealmSwift

@objcMembers class PickupLine: Object {
    dynamic var line: String = ""
    let score = RealmOptional<Int>()
    dynamic var email: String? = nil
    
    convenience init(line: String, score: Int?, email: String?) {
        self.init()
        self.line = line
        self.score.value = score
        self.email = email
    }
    
    func scoreString() -> String? {
        guard let score = score.value else {return nil}
        return String(score)
    }
}
