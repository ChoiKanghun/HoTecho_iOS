//
//  FourthView.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/31.
//

import UIKit

let DidChangeTableViewHeightNotification: Notification.Name =
    Notification.Name("DidChangeTableViewHeightNotification")
let userInfoTableViewHeight:String = "TableViewHeight"



class FourthView: UIViewController {

    let tableViewCellIdentifier: String = "fourthTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("tableViewController called")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async {
            NotificationCenter.default.post(name: DidChangeTableViewHeightNotification, object: nil, userInfo: [userInfoTableViewHeight:self.tableView.contentSize.height])
        }
      
    }
    
}

extension FourthView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier) as? FourthTableViewCell
        else {
            return UITableViewCell()}
        cell.label.text = "\(indexPath.row)"
        cell.backgroundColor = .gray
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    
}
