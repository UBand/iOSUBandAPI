
//
//  UBandAPI.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//

import Foundation
import UIKit

public class UBandAPI{
    weak var delegate:UBandAPIDelegate?
    private var _bleController : BleController!
    //let bleController = BleController()
    
    var temperatureUnit:TemperatureUnit?
    var isRealTimeData:Bool?
    var intervalTimeData:Int?
    
    var bleController:BleController{
        return _bleController
    }
    
    init(){
        self.temperatureUnit = delegate?.preferredTemperatureUnit(self)
        self.isRealTimeData = delegate?.isRealTimeData(self)
        self.intervalTimeData = delegate?.preferredIntervalTimeData(self)
        
        
        //Set up the uband api with the preferred specified settings
        self._bleController = BleController(ubandApi: self)
    }
    
    func setHeartRateData(obtainedHeartRate: UInt){
        delegate?.didReceiveHeartRateData(self, heartRate: obtainedHeartRate)
        //Other logic related to heart rate
    }
    
    func setGyroscopeData(obtainedX: Float,obtainedY:Float,obtainedZ:Float){
        delegate?.didReceiveGyroscopeData(self, x: obtainedX, y: obtainedY, z: obtainedZ)
        //Other logic
    }
    
    func setTemperatureData(obtainedTemperature: Float){
        var calcTemperature:Float
        switch self.temperatureUnit! {
        case TemperatureUnit.Fahrenheit:
            calcTemperature = (obtainedTemperature * 1.8) + 32
        case TemperatureUnit.Kelvin:
            calcTemperature = obtainedTemperature + 273.15
        default:
            calcTemperature = obtainedTemperature
        }
        delegate?.didReceiveTemperatureData(self, temperature: calcTemperature)
        //Other logic related to heart rate
    }
    
    func setBatteryLevelData(obtainedBatteryLevel: Float){
        delegate?.didReceiveBatteryLevelData(self, batteryLevel: obtainedBatteryLevel)
        //Other logic related to heart rate
    }
    
    func setAccelerometerData(x: Float,y:Float,z:Float){
        delegate?.didReceiveAccelerometerData(self, x: x, y: y, z: z)
        //Other logic related to heart rate
    }
    func setSweatingData(sweat: Float){
        delegate?.didReceiveSweatingData(self, value: sweat)
        //Other logic related to heart rate
    }
    
    
    
}