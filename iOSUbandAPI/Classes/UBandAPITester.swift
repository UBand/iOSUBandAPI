//
//  UBandAPITester.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

class UBandAPITester: UBandAPIDelegate{
    
    var myUBand:CBPeripheral!

    
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
        print("x: \(x)")
        print("y: \(y)")
        print("z: \(z)")
    }
    
    func didReceiveTemperatureData(uBand: UBandAPI, temperature: Float) {
         // do something uBand developer
    }
    
    func didReceiveBatteryLevelData(uBand: UBandAPI, batteryLevel: Int) {
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
