//
//  Grade.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/12.
//

import Foundation

class Grade: Codable {
    var id: String?
    var name: String?
    var checked: String?
    var hour: String?
    var grade: String?
    var point: Double = 0.0
}

class dbGrade: Codable {
    var id: Int = 1
    var name: String?
    var result: String?
    var avgType: Int = 4
    var list: [Grade]?
}
