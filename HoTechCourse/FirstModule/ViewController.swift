//
//  ViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let childViewController = segue.destination as? TestTableViewController {
            childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
