//
//  traceViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/30.
//

import UIKit
import SQLite3


class traceViewController: UIViewController {

    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openDB()
        // Do any additional setup after loading the view.
    }
    
    func openDB(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TraceDatabase.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("DB 열기 실패")
        }
        print(fileURL)

        var queryStatementString = "DROP TABLE TRACE"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(queryStatement) == SQLITE_DONE {
                print("Successfully deleted")
            } else {
                print("DELETE statement couldn't be prepared")
            }
            sqlite3_finalize(queryStatement)
        }
        /*if sqlite3_exec(db,"CREATE TABLE IF NOT EXISTS TRACE (id INTEGER PRIMARY KEY AUTOINCREMENT, latitude DOUBLE, longtitude DOUBLE)", nil, nil, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errorMessage)")
        }*/
    }
    

}
