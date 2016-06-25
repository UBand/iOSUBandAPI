//
//  UBandDelegate.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//
import Foundation
import UIKit

public protocol UBandAPIDelegate:class{
    
    //API Settings
    func preferredTemperatureUnit(uBand: UBandAPI) -> TemperatureUnit?
    func isRealTimeData(uBand: UBandAPI) -> Bool?
    func preferredIntervalTimeData(uBand: UBandAPI) -> Int?
    
    //API Methods
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate:UInt)
    func didReceiveGyroscopeData(uBand: UBandAPI, x:Float,y:Float,z:Float)
    func didReceiveTemperatureData(uBand: UBandAPI,temperature:Float)
    func didReceiveBatteryLevelData(uBand: UBandAPI,batteryLevel:Float)
    func didReceiveAccelerometerData(uBand: UBandAPI,x:Float,y:Float,z:Float)
    func didReceiveSweatingData(uBand: UBandAPI,value:Float)
}
