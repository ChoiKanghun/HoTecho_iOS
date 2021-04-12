//
//  DBHelper.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/12.
//

import Foundation
import SQLite3

class DBHelper {
    var db: OpaquePointer?
    var path: String = "myDB.sqlite" // DB_name, 확장자 지킬 것.
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
    
        var db: OpaquePointer? = nil
        
        // return something into db(2nd parameter)
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
        } else {
            print("Database has been created with path \(path)")
            print("path to DB is : \(filePath.path)")
            return db
        }
        
        return db
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS grade(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, avg INTEGER, result TEXT, list TEXT);"
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("table creation success")
            }
            else {
                print("table creation Failed")
            }
        } else {
            print("sqlite3 prepare v2 error")
        }
    }
}
