//
//  ViewController.swift
//  iOSUbandAPI
//
//  Created by Karen Gonzalez on 06/24/2016.
//  Copyright (c) 2016 Karen Gonzalez. All rights reserved.
//

import UIKit
import iOSUbandAPI

class ViewController: UIViewController, UBandAPIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Settings
    func preferredTemperatureUnit(uBand: UBandAPI) -> TemperatureUnit? {
        return TemperatureUnit.Fahrenheit
    }
    
    func preferredIntervalTimeData(uBand: UBandAPI) -> Int? {
        return 0
    }
    
    func isRealTimeData(uBand: UBandAPI) -> Bool? {
        return true
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
    
    func didReceiveBatteryLevelData(uBand: UBandAPI, batteryLevel: Float) {
        // do something uBand developer
    }
    
    func didReceiveAccelerometerData(uBand: UBandAPI, x: Float, y: Float, z: Float) {
        // do something uBand developer
    }
    
    func didReceiveSweatingData(uBand: UBandAPI, value: Float) {
        // do something uBand developer
    }


}

