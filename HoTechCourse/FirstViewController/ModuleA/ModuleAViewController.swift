//
//  ModuleAViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/31.
//

import UIKit

let DidChangeModuleAHeightNotification: Notification.Name =
    Notification.Name("DidChangeModuleAHeightNotification")
let userInfoModuleAHeight:String = "moduleAHeight"

class ModuleAViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.numberOfLines = 0
        label.backgroundColor = .red
        label.text = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("after showing label text: \(self.label.frame.height)")
        
        NotificationCenter.default.post(name: DidChangeModuleAHeightNotification, object: nil, userInfo: [userInfoModuleAHeight:self.label.frame.height])
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
