//
//  ProximityViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/08.
//

import UIKit

class ProximityViewController: UIViewController {

    @IBOutlet weak var proximtyLabel: UILabel!
    @IBOutlet weak var orientationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isProximityMonitoringEnabled = true
        
        proximtyLabel?.text = "\(UIDevice.current.proximityState)"
    }
    
    @IBAction func checkProximty(_ sender: Any) {
        proximtyLabel?.text = "\(UIDevice.current.proximityState)"
        if UIDevice.current.orientation.isPortrait == true {
            orientationLabel?.text = "portrait"

        }
        else if UIDevice.current.orientation.isFlat == true {
            orientationLabel?.text = "Flat"
        }
        else if UIDevice.current.orientation.isLandscape == true {
            orientationLabel?.text = "Landscape"
        }
        else if UIDevice.current.orientation.isValidInterfaceOrientation == true {
            orientationLabel?.text = "isValidInterfaceOrientation"
        } else {
            orientationLabel?.text = "invalid orientation"
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
