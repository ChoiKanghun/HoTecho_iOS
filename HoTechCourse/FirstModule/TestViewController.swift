//
//  TestViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/28.
//

import UIKit

class testViewController: UIViewController {
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension testViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.testTableView.dequeueReusableCell(withIdentifier: "testTableViewCell")
        else {
            return UITableViewCell()
        }
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
}
