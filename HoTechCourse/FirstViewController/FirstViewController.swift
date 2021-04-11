//
//  FirstViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/03/31.
//

import UIKit

class FirstViewController: UIViewController {
    
    var defaultSumOfHeightConstraint: CGFloat = 1
    
    @IBOutlet weak var sumOfHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var BViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var AViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("parent view controller called")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHeightNotification(_:)), name: DidChangeAViewHeightNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHeightNotification(_:)), name: DidChangeBViewHeightNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHeightNotification(_:)), name: DidChangeCollectionViewHeightNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHeightNotification(_:)), name: DidChangeTableViewHeightNotification, object: nil)
        
        self.defaultSumOfHeightConstraint = self.sumOfHeightConstraints.constant
        
    }

    @objc func didReceiveHeightNotification(_ noti: Notification) {
        if noti.name == DidChangeAViewHeightNotification {
            guard let moduleAHeight = noti.userInfo?[userInfoAViewHeight] as? CGFloat
            else {
                print("getting moduleAHeight on AViewController failure")
                return
            }
            if (sumOfHeightConstraints.constant - moduleAHeight < 0) {
                sumOfHeightConstraints.constant = moduleAHeight
            }
            self.AViewHeightConstraint.constant = moduleAHeight

        } else if noti.name == DidChangeBViewHeightNotification  {
            guard let BViewHeight = noti.userInfo?[userInfoBViewHeight] as? CGFloat
            else {return}
            
            let totalHeightConstant = self.AViewHeightConstraint.constant
                                        + BViewHeight
            if (sumOfHeightConstraints.constant - totalHeightConstant < 0) {
                sumOfHeightConstraints.constant = totalHeightConstant
            }
            self.BViewHeightConstraint.constant = BViewHeight
            
        } else if noti.name == DidChangeCollectionViewHeightNotification {
            guard let CollectionViewHeight = noti.userInfo?[userInfoCollectionViewHeight] as? CGFloat
            else {return}
            
            let totalHeight = self.AViewHeightConstraint.constant +
                self.BViewHeightConstraint.constant +
                CollectionViewHeight + self.tableViewHeightConstraint.constant
            if (sumOfHeightConstraints.constant -
                    totalHeight
                    < 0) {
                sumOfHeightConstraints.constant = totalHeight
            }
            self.collectionViewHeightConstraint.constant = CollectionViewHeight

        } else if noti.name == DidChangeTableViewHeightNotification {
            guard let TableViewHeight = noti.userInfo?[userInfoTableViewHeight] as? CGFloat
            else {return}
            
            let totalHeightConstant = self.AViewHeightConstraint.constant +
                self.BViewHeightConstraint.constant +
                self.collectionViewHeightConstraint.constant +
                TableViewHeight
                
            
            if sumOfHeightConstraints.constant - totalHeightConstant < 0 {
                sumOfHeightConstraints.constant = totalHeightConstant
            }
            
            self.tableViewHeightConstraint.constant = TableViewHeight
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
