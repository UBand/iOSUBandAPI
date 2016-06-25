//
//  UBandAPITester.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//

import Foundation
import UIKit

class UBandAPITester: UBandAPIDelegate{
    
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
        print("x: \(x)")
        print("y: \(y)")
        print("z: \(z)")
    }
    
    func didReceiveTemperatureData(uBand: UBandAPI, temperature: Float) {
         // do something uBand developer
    }
    
    func didReceiveBatteryLevelData(uBand: UBandAPI, batteryLevel: Float) {
         // do something uBand developer
    }
    
    func didReceiveAccelerometerData(uBand: UBandAPI, x: Float, y: Float, z: Float) {
         // do something uBand developer
        print("x: \(x)")
        print("y: \(y)")
        print("z: \(z)")
    }
    
    func didReceiveSweatingData(uBand: UBandAPI, value: Float) {
         // do something uBand developer
        print("sweat: \(value)")
    }
    
}
