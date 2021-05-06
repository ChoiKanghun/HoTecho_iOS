//
//  PickupLinesViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/04.
//

import UIKit
import RealmSwift

class PickupLinesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pickupLines: Results<PickupLine>!
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // CRUD의 'R'
        // realm은 읽어낸 data 컬렉션을 memory에 올리지 않고 정보를 얻기 때문에
        // 다른 DB 라이브러리보다 훨씬 효율적이다.
        let realm = RealmService.shared.realm
        self.pickupLines = realm.objects(PickupLine.self)
        
        // 아래를 적어줌으로써 realm DB에 업데이트가 있을 때마다
        // tableView의 데이터를 리로드한다.
        notificationToken = pickupLines.observe { (changes) in
            self.tableView.reloadData()
        }
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "unrecognized error")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        RealmService.shared.stopObservingErrors(in: self)
    }
    
    
    @IBAction func onAddTapped() {
        AlertService.addAlert(in: self) { (line, score, email) in
            let newPickupLine = PickupLine(line: line, score: score, email: email)
            RealmService.shared.create(newPickupLine)
        }
    }
    
}

extension PickupLinesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickupLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pickupLineCell") as? PickupLineTableViewCell
        else {return UITableViewCell()}
        
        let pickupLine = pickupLines[indexPath.row]
        cell.configure(with: pickupLine)
        
        return cell
    }
}

extension PickupLinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        
        let pickupLine = pickupLines[indexPath.row]
        
        AlertService.updateAlert(in: self, pickupLine: pickupLine) {
            (line, score, email) in
            let dict: [String: Any?] = ["line": line,
                                        "score": score,
                                        "email": email]
            RealmService.shared.update(pickupLine, with: dict)
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let pickupLine = pickupLines[indexPath.row]
        RealmService.shared.delete(pickupLine)
    }
    
}
