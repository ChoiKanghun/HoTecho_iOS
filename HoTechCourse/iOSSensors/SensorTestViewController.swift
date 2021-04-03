//
//  SensorTestViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/02.
//

import UIKit
import CoreMotion



class SensorTestViewController: UIViewController {

    @IBOutlet weak var accXLabel: UILabel!
    @IBOutlet weak var accYLabel: UILabel!
    @IBOutlet weak var accZLabel: UILabel!
    @IBOutlet weak var gyroXLabel: UILabel!
    @IBOutlet weak var gyroYLabel: UILabel!
    @IBOutlet weak var gyroZLabel: UILabel!
    @IBOutlet weak var accelerationStatusLabel: UILabel!
    @IBOutlet weak var gyroStatusLabel: UILabel!
    
    @IBOutlet weak var attitudePitchLabel: UILabel!
    @IBOutlet weak var attitudeRollLabel: UILabel!
    @IBOutlet weak var attitudeYawLabel: UILabel!

    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.enrollAccelerationGyroSensorTest()
        self.enrollCMDeviceMotionAttitude()
        
    }
}

// MARK:- 가속도/자이로
extension SensorTestViewController {
    func enrollAccelerationGyroSensorTest() {
/*
 가속도 센서 및 자이로 센서는
 `CoreMotion`을 import해야 한다.
 var motionManager에 할당한 CMMotionManager()를 이용한다.
         
*/
        
        
        // 데이터를 초단위 시간에 한번 받도록 설정.
        // 설정값이 1/10 ~ 1/20 인 경우 디바이스의 방향벡터를 조사하는 목적으로 사용되고,
        // 1/30 ~ 1/60 인 경우 실시간 가속도 센서를 이용하는 애플리케이션에 사용된다고 한다.
        motionManager.accelerometerUpdateInterval = 0.1 // 가속도
        motionManager.gyroUpdateInterval = 0.1 // 자이로스코프
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
            (accelerometerData: CMAccelerometerData!, error: Error!) -> Void in
            self.getAccelerationData(accelerometerData.acceleration)
            if (error != nil) {
                print(error!)
            }
        
        })
        
        motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: {
            (gyroData: CMGyroData!, error: Error!) -> Void in
            self.getGyroData(gyroData.rotationRate)
            if (error != nil) {
                print (error!)
            }
        })
         
    }
    
    func getAccelerationData(_ acceleration: CMAcceleration) {
        accXLabel?.text = "\(acceleration.x)"
        accYLabel?.text = "\(acceleration.y)"
        accZLabel?.text = "\(acceleration.z)"
        
        if fabs(acceleration.x) > 2 {
            self.accelerationStatusLabel?.text = "x축 가속도 측정됨"
        }
        else if fabs(acceleration.y) > 2 {
            self.accelerationStatusLabel?.text = "y축 가속도 측정됨"
        }
        else if fabs(acceleration.z) > 2 {
            self.accelerationStatusLabel?.text = "z축 가속도 측정됨"
        }
    }
    
    func getGyroData(_ rotation: CMRotationRate) {
        gyroXLabel?.text = "\(rotation.x)"
        gyroYLabel?.text = "\(rotation.y)"
        gyroZLabel?.text = "\(rotation.z)"
        
        if abs(rotation.x) > 2 {
            self.gyroStatusLabel?.text = "x축 회전 측정됨"
        }
        else if abs(rotation.y) > 2 {
            self.gyroStatusLabel?.text = "y축 회전 측정됨"
        }
        else if abs(rotation.z) > 2 {
            self.gyroStatusLabel?.text = "z축 회전 측정됨"
        }
    }
}

// MARK:- DeviceMotion
extension SensorTestViewController {
    func enrollCMDeviceMotionAttitude() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
            (deviceMotionData: CMDeviceMotion!, error: Error!) in
            self.attitudePitchLabel?.text
                = "Pitch: \(deviceMotionData.attitude.pitch * 10)"
            self.attitudeRollLabel?.text = "Roll: \(deviceMotionData.attitude.roll * 10)"
            self.attitudeYawLabel?.text = "Yaw: \(deviceMotionData.attitude.yaw * 10)"
        })
        let CMPedo = CMPedometer()
        CMPedometer.startUpdates(CMPedo)
    }
    
}
