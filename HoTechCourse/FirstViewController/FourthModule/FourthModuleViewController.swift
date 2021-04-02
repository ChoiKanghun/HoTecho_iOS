//
//  FourthModuleViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/30.
//

import UIKit

class FourthModuleViewController: UIViewController {

    let tableViewCellIdentifier = "FourthModuleTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension FourthModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier) as? FourthModuleTableViewCell
        else {
            print("cell converting to fourthmoduletableviewcell failure")
            return UITableViewCell()}
        
        cell.label?.text = "\(indexPath.row)"
        cell.backgroundColor = .orange
        
        return cell
    }
}
