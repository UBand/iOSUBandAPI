
//
//  UBandAPI.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

public class UBandAPI{
    weak var delegate:UBandAPIDelegate?
    private var _bleController : BleController!
    
    var temperatureUnit:TemperatureUnit?
    var selectedUBand:CBPeripheral?
    var uBandPeripherals:[CBPeripheral]=[]
    
    var bleController:BleController{
        return _bleController
    }
    
    init(){
        
        self._bleController = BleController(ubandApi: self)
        self.temperatureUnit = TemperatureUnit.Celsius
        
        //Set up the uband api with the preferred specified settings

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
    
    func setBatteryLevelData(obtainedBatteryLevel: Int){
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
    
    func addDiscoveredUBandPeripheral(uband:CBPeripheral)
    {
       let keepLooking = delegate?.didDiscoveredUBandPeripheral(self, uBandPeripheral: uband)
       uBandPeripherals.append(uband)
        if keepLooking==false{
            connectToAvailableUBands()
        }
    }
    
    func connectToAvailableUBands(){
        self.selectedUBand = delegate?.connectToAvailableUBands(self, availableUBands: uBandPeripherals)
        self._bleController.connectToUbandPeripheral(selectedUBand!)
    }
    
    
    
    
}