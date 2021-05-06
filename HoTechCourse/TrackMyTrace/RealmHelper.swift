//
//  RealmHelper.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import Foundation
import RealmSwift
import UIKit

class RealmHelper {
    private init() {}
    
    static let shared = RealmHelper()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("realm create error: \(error)")
        }
    }
    
    
}
