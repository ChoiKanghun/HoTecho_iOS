//
//  TraceListViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import UIKit
import RealmSwift

class TraceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    // Trace들을 DB로부터 Read하여 담을 변수
    var TrackDatas: Results<TrackData>!
    // Trace 업데이트시 자동으로 테이블뷰 reload하는 데에 쓸 변수
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = RealmHelper.shared.realm
        self.TrackDatas = realm.objects(TrackData.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        notificationToken = TrackDatas.observe { (changes) in
            self.tableView.reloadData()
            print("changes: \(changes)")
        }
    }


}

extension TraceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrackDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TraceTableViewCell") as? TraceInfoTableViewCell
        else {return UITableViewCell()}
        
        let trackData = self.TrackDatas[indexPath.row]
        cell.labelDate?.text = trackData.formattedDate() + "의 기록"
        print("trackData\(indexPath.row): \(trackData)")
        return cell
    }
}

extension TraceListViewController: UITableViewDelegate {
    
}
