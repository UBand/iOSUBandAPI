//
//  UBandDelegate.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//




import Foundation
import UIKit
import CoreBluetooth

public protocol UBandAPIDelegate:class{
    
    //API Settings
    
    /**
     
     Sets the temperature measure unit.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Returns: TemperatureUnit.
     
     */
    
    //func preferredTemperatureUnit(uBand: UBandAPI) -> TemperatureUnit?
    
    //API Methods
    
    /**
     
     List all the available UBands to connect
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter availableUBands: An array of CBPeripheral containing all the available UBands
     
     - Returns: CBPeripheral
     
     */

    func connectToAvailableUBands(uBand: UBandAPI,availableUBands:[CBPeripheral]) -> CBPeripheral?
    
    /**
     
     Method to show when a new UBand peripheral was discovered
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter uBandPeripheral: The discovered uBand
     
     - Returns: Bool. 
     
       It indicates if the user wants to keep looking for uBands.
     
       True: Keep looking.
     
       False: Stop looking to retrive the available uBands
     
     */
    func didDiscoveredUBandPeripheral(uBand: UBandAPI,uBandPeripheral:CBPeripheral) -> Bool?
    /**
     
     Connect to specified peripheral UBand.
     
     - Parameter uBand: An UBandAPI object.
     
     - Returns: CBPeripheral (UBand) to connect.
     
     */
    
    //func connectToUBand(uBand:UBandAPI) -> CBPeripheral?
    
    /**
     
     Method to process each data received from the heart rate sensor.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter heartRate: An unsigned integer with the value received.
     
     */
    
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate:UInt)
    
    /**
     
     Method to process each data received from the gyroscope.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter x: A float with the value received for the x axis.
     
     - Parameter y: A float with the value received for the y axis.
     
     - Parameter z: A float with the value received for the z axis.
     
     */
    
    func didReceiveGyroscopeData(uBand: UBandAPI, x:Float,y:Float,z:Float)
    
    /**
     
     Method to process each data received from the temperature.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter temperature: A float with the value received.
     
     */
    
    func didReceiveTemperatureData(uBand: UBandAPI,temperature:Float)
    
    /**
     
     Method to process each data received from the battery charge sensor.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter batteryLevel: An Int with the value received.
     
     */
    
    func didReceiveBatteryLevelData(uBand: UBandAPI,batteryLevel:Int)
    
    /**
     
     Method to process each data received from the accelerometer.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter x: A float with the value received for the x axis.
     
     - Parameter y: A float with the value received for the y axis.
     
     - Parameter z: A float with the value received for the z axis.
     
     */
    
    func didReceiveAccelerometerData(uBand: UBandAPI,x:Float,y:Float,z:Float)
    
    /**
     
     Method to process each data received from the sweating sensor.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter value: A float with the value received.
     
     */
    

    func didReceiveSweatingData(uBand: UBandAPI,value:Float)

}

extension UBandAPIDelegate{
    func preferredTemperatureUnit(uBand: UBandAPI)-> TemperatureUnit?{
        return TemperatureUnit.Celsius
    }
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate:UInt){}
    func didReceiveGyroscopeData(uBand: UBandAPI, x:Float,y:Float,z:Float){}
    func didReceiveTemperatureData(uBand: UBandAPI,temperature:Float){}
    func didReceiveBatteryLevelData(uBand: UBandAPI,batteryLevel:Int){}
    func didReceiveAccelerometerData(uBand: UBandAPI,x:Float,y:Float,z:Float){}
    func didReceiveSweatingData(uBand: UBandAPI,value:Float){}
}

