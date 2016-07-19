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
    
    //API Methods
    
    
    /**
     
     Method to process the connection status after trying to connect to a U-Band.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter success: Returns true if there was an error.
     
     - Parameter error: Returns the error description is there was one.
     
     */
    
    func didReceiveConnectionStatus(uBand: UBandAPI,success:Bool,error:NSError?)
    
    /**
     
     Method to handle an U-Band disconnection.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     */
    
    func didDisconnectUBand(uBand: UBandAPI)
    
    /**
     
     Method to handle a discovered U-Band peripheral.
     
     
     
     - Parameter uBand: An UBandAPI object.
     
     - Parameter uBandPeripheral: The discovered UBand Peripheral
     
     */
    
    func didDiscoveredUBandPeripheral(uBand: UBandAPI,uBandPeripheral:CBPeripheral)
    
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
    
    /**
     
     Method to notifiy when there was a new step.
     
     
     - Parameter uBand: An UBandAPI object.
     
     */
    
    func didRecognizeStep(uBand: UBandAPI)
    
}

public extension UBandAPIDelegate{
    func didReceiveConnectionStatus(uBand: UBandAPI,success:Bool,error: NSError?){}
    func didDisconnectUBand(uBand: UBandAPI){}
    func didDiscoveredUBandPeripheral(uBand: UBandAPI,uBandPeripheral:CBPeripheral){}
    func didReceiveHeartRateData(uBand: UBandAPI, heartRate:UInt){}
    func didReceiveGyroscopeData(uBand: UBandAPI, x:Float,y:Float,z:Float){}
    func didReceiveTemperatureData(uBand: UBandAPI,temperature:Float){}
    func didReceiveBatteryLevelData(uBand: UBandAPI,batteryLevel:Int){}
    func didReceiveAccelerometerData(uBand: UBandAPI,x:Float,y:Float,z:Float){}
    func didReceiveSweatingData(uBand: UBandAPI,value:Float){}
    func didRecognizeStep(uBand: UBandAPI){}
}

