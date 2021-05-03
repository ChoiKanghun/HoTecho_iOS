import Foundation
import SQLite3

class DBHelper {
    var db: OpaquePointer?
    var path: String = "crudTestDB.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
    
        var db: OpaquePointer? = nil
    
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
          print("Error while creating db")
          return nil
        } else {
          print("Database has been created with path \(path)")
          return db
        }
    }
    
    func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS pedo(id INTEGER PRIMARY KEY AUTOINCREMENT, latitude DOUBLE, longtitude DOUBLE);"
        
        var createTablePtr: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableQuery, -1, &createTablePtr, nil) == SQLITE_OK {
            if sqlite3_step(createTablePtr) == SQLITE_DONE {
                print("table creation has been successfully done")
            }
            else {
                print("table creation failure")
            }
        } else {
            print("Preparation for creating table has been failed")
        }
    }
}
