//
//  BlueToothViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/04/05.
//

import CoreBluetooth
import UIKit

class BlueToothViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var centralManager: CBCentralManager!
    var macbookPeripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
   
}

extension BlueToothViewController: CBCentralManagerDelegate {
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        
        case .unknown:
            print("central.state is unknown")
        case .resetting:
            print("central.state is resetting")
        case .unsupported:
            print("central.state is unsupported")
        case .unauthorized:
            print("central.state is unauthorized")
        case .poweredOff:
            print("central.state is poweredOff")
        case .poweredOn:
            print("central.state is poweredOn")
            self.textView.text += "central.state is powered on"
            centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("central.state default case")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheral.identifier.uuidString == "DB469E0F-2CDE-D87B-BD7E-6D4191D6A646" {
            self.macbookPeripheral = peripheral
            self.textView.text += "\n\(peripheral)"
            macbookPeripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(macbookPeripheral)
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.textView.text += "\nConnected"

        
        // 아래 파라미터가 nil이면 모든 서비스를 검색.
        macbookPeripheral.discoverServices(nil)
        // 연결 끊기
//        centralManager.cancelPeripheralConnection(peripheral)
    }
    
}

extension BlueToothViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = macbookPeripheral.services else {return}
        for service in services {
            self.textView.text += "\n\(service)"
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
        for characteristic in characteristics {
            print("characteristic: \(characteristic)")
            if characteristic.properties.contains(.read) {
                print("readable")
                peripheral.readValue(for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateValueFor characteristic")
        self.textView.text += "\n\(characteristic.value!)"
    }
}
