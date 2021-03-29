//
//  JustViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/29.
//

import UIKit

class JustViewController: UIViewController {
    
    @IBOutlet weak var testTableView: UITableView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testTableView.delegate = self
        testTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.testTableView.reloadData()
    }
    
}
