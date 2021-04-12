//
//  SQLiteViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/12.
//

import UIKit
import SQLite3



class SQLiteViewController: UIViewController {

    // (시뮬레이터) 디렉터리 위치에 데이터베이스가 생성됨.
    var db: OpaquePointer?

    @IBOutlet weak var titleTF: UILabel!
    @IBOutlet weak var sublineTF: UILabel!
    @IBOutlet weak var todayDateTF: UILabel!
    
    override func viewDidLoad() {
        
    }

    

}
