//
//  FirstView.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/31.
//

import UIKit

let DidChangeAViewHeightNotification: Notification.Name =
    Notification.Name("DidChangeAViewHeightNotification")
let userInfoAViewHeight:String = "AViewHeight"


class FirstView: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.post(name: DidChangeAViewHeightNotification, object: nil, userInfo: [userInfoAViewHeight:self.label.frame.height])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("AViewController called")
        
        self.label.numberOfLines = 0
        self.label?.text = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        self.view.translatesAutoresizingMaskIntoConstraints = false
//
//
//        if let viewController = storyboard.instantiateViewController(identifier: "ModuleAViewController") as? ModuleAViewController {
//            addChild(viewController)
//            self.view.addSubview(viewController.view)
////            AViewVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
//            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            }
//
        
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
