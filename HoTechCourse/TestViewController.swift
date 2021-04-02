//
//  TestViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/30.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var testTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testTableView.delegate = self
        self.testTableView.dataSource = self
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

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.testTableView.dequeueReusableCell(withIdentifier: "testTableViewCell") as? TstTableViewCell
        else {return UITableViewCell()}
        
        cell.backgroundColor = .orange
        cell.testLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

extension TestViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // 현재 스크롤의 위치 (최상단 = 0)
            let y: CGFloat = scrollView.contentOffset.y
            
            //변경될 최상단 뷰의 높이
            let ModifiedTopHeight: CGFloat = viewTopHeight.constant - y
            let maxTopHeight:CGFloat = 300
            let minTopHeight:CGFloat = 120
            // *** 변경될 높이가 최댓값을 초과함
            if(ModifiedTopHeight > maxTopHeight)
            {
                //현재 최상단뷰의 높이를 최댓값(250)으로 설정
                viewTopHeight.constant = maxTopHeight
            }// *** 변경될 높이가 최솟값 미만임
            else if(ModifiedTopHeight < minTopHeight)
            {
                //현재 최상단뷰의 높이를 최솟값(50+상태바높이)으로 설정
                viewTopHeight.constant = minTopHeight
            }// *** 변경될 높이가 최솟값(50+상태바높이)과 최댓값(250) 사이임
            else
            {
                //현재 최상단 뷰 높이를 변경함
                viewTopHeight.constant = ModifiedTopHeight
                scrollView.contentOffset.y = 0
            }
    }
}
