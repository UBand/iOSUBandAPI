//
//  ViewController.swift
//  iOSUbandAPI
//
//  Created by Karen Gonzalez on 06/24/2016.
//  Copyright (c) 2016 Karen Gonzalez. All rights reserved.
//

import UIKit
import iOSUbandAPI
import CoreBluetooth

class ViewController: UIViewController, UBandAPIDelegate {
    
    var myUBand:CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Settings
    func didDiscoveredUBandPeripheral(uBand: UBandAPI, uBandPeripheral: CBPeripheral)->Bool? {
        // do something UBand Developer
        //return false if wants to stop the scanning and retrieve available ubands to connect
        return false
    }
    
    
    func connectToAvailableUBands(uBand: UBandAPI, availableUBands: [CBPeripheral])-> CBPeripheral? {
        // do something with available UBands
        return myUBand
    }
    
    
    //Api methods
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate: UInt) {
        // do something uBand developer
    }
    
    func didReceiveGyroscopeData(uBand: UBandAPI, x: Float, y: Float, z: Float) {
        // do something uBand developer
    }
    
    func didReceiveTemperatureData(uBand: UBandAPI, temperature: Float) {
        // do something uBand developer
    }
    
    func didReceiveBatteryLevelData(uBand: UBandAPI, batteryLevel: Int) {
        // do something uBand developer
    }
    
    func didReceiveAccelerometerData(uBand: UBandAPI, x: Float, y: Float, z: Float) {
        // do something uBand developer
    }
    
    func didReceiveSweatingData(uBand: UBandAPI, value: Float) {
        // do something uBand developer
    }


}

