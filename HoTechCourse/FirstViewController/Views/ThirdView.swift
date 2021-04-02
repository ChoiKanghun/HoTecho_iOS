//
//  ThirdView.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/31.
//

import UIKit

let DidChangeCollectionViewHeightNotification: Notification.Name =
    Notification.Name("DidChangeCollectionViewHeightNotification")
let userInfoCollectionViewHeight:String = "CollectionViewHeight"


class ThirdView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: DidChangeCollectionViewHeightNotification, object: nil, userInfo: [userInfoCollectionViewHeight:self.collectionView.contentSize.height])
            

        }
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

extension ThirdView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "thirdViewCollectionViewCell", for: indexPath) as? ThirdViewCollectionViewCell
        else {return UICollectionViewCell()}
        cell.backgroundColor = .orange
        cell.label.text = "\(indexPath.row)"
        return cell
    }
}
