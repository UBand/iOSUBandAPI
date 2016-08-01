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
    var uBand:UBandAPI?
    
    init(){
        uBand?.delegate = self
    }
    
    //Settings
    
    func preferredUserAge(uBand: UBandAPI) -> Int? {
        let age = 22
        return age
    }
    
    func preferredUserWeight(uBand: UBandAPI) -> Float? {
        let weightKilo = Float(51.4)
        return weightKilo
    }
    
    func preferredUserGender(uBand: UBandAPI) -> Gender? {
        return Gender.Woman
    }
    
    
    func didDiscoveredUBandPeripheral(uBand: UBandAPI, uBandPeripheral: CBPeripheral) {
        // do something UBand Developer
        //return false
    }
    
    
    func connectToAvailableUBands(uBand: UBandAPI, availableUBands: [CBPeripheral])-> CBPeripheral? {
        // do something with available UBands
        return myUBand
    }
    
    
    //Api methods
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate: Int) {
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
