//
//  AlertService.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/04.
//

import Foundation
import UIKit

class AlertService {
    private init() {}
    
    static func addAlert(in vc: UIViewController,
            completion: @escaping (String, Int?, String?) -> Void) {
        let alert = UIAlertController(title: "Add Line", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTextField) in
            lineTextField.placeholder = "Enter Pickup Line"
        }
        alert.addTextField { (scoreTextField) in
            scoreTextField.placeholder = "Enter Score"
        }
        alert.addTextField { (emailTextField) in
            emailTextField.placeholder = "Enter Email"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                  let scoreString = alert.textFields?[1].text,
                  let emailString = alert.textFields?.last?.text
            else {return}
        
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            
            completion(line, score, email)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    static func updateAlert(in vc: UIViewController,
                            pickupLine: PickupLine,
                            completion: @escaping (String, Int?, String?) -> Void) {
        let alert = UIAlertController(title: "Update Line",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { (lineTextField) in
            lineTextField.placeholder = "Enter line"
            lineTextField.text = pickupLine.line
        }
        alert.addTextField { (scoreTextField) in
            scoreTextField.placeholder = "Enter score"
            scoreTextField.text = pickupLine.scoreString()
        }
        alert.addTextField{ (emailTextField) in
            emailTextField.placeholder = "Enter email"
            emailTextField.text = pickupLine.email
        }
        
        let action = UIAlertAction(title: "Update",
                                   style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                  let scoreString = alert.textFields?[1].text,
                  let emailString = alert.textFields?.last?.text
            else {return}
            
            let score = scoreString == "" ? nil : Int(scoreString)
            let email = emailString == "" ? nil : emailString
            
            completion(line, score, email)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
