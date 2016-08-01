
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
    public weak var delegate:UBandAPIDelegate?
    public var uBandName:String?
    private var _bleController : BleController!
    
    var temperatureUnit:TemperatureUnit?
    var selectedUBand:CBPeripheral?
    var uBandPeripherals:[CBPeripheral]=[]
    var countingCalories:Bool=true
    var caloriesCounter = 0
    var userGender:Gender?
    var userWeight:Float?
    var userAge:Int?
    var userHeartRateAvg:Float?=0
    var oldBPM:Int?=0
    var recordingCaloriesTimer:NSDate?
    var contBPMRecs = 0
    
    var bleController:BleController{
        return _bleController
    }
    
    public init(d:UBandAPIDelegate ){
        self.delegate = d
        self._bleController = BleController(ubandApi: self)
        self.temperatureUnit = TemperatureUnit.Celsius
        self.userGender = delegate?.preferredUserGender(self)
        self.userWeight = (delegate?.preferredUserWeight(self))! * Float(2.20462) // 1Kg equal 2.20642 Libs
        self.userAge = delegate?.preferredUserAge(self)
        //Set up the uband api with the preferred specified settings
        
    }
    
    func setHeartRateData(obtainedHeartRate: Int){
        if(countingCalories){
            setNewHeartRateAverage(obtainedHeartRate)
        }
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
    
    func setNewStep(){
        delegate?.didRecognizeStep(self)
    }
    
    func setSweatingData(sweat: Float){
        delegate?.didReceiveSweatingData(self, value: sweat)
        //Other logic related to heart rate
    }
    
    func addDiscoveredUBandPeripheral(uband:CBPeripheral)
    {
        delegate?.didDiscoveredUBandPeripheral(self, uBandPeripheral: uband)
        uBandPeripherals.append(uband)
    }
    
    func notifyPeripheralConnectionStatus(success:Bool,error:NSError?){
        if(success){
            let uuid = selectedUBand!.identifier.UUIDString
            self.uBandName = (selectedUBand?.name)! + String(uuid.characters.suffix(4))
        }
        delegate?.didReceiveConnectionStatus(self,success: success,error:error)
    }
    
    func notifyUBandDisconnected(){
        delegate?.didDisconnectUBand(self)
    }
    
    // Public Methods to UBand's developer
    
    public func connectToUBand(uBand:CBPeripheral){
        self.selectedUBand = uBand
        self._bleController.connectToUbandPeripheral(selectedUBand!)
    }
    
    public func startCountingCalories(){
        countingCalories = true
        recordingCaloriesTimer = NSDate()
    }
    
    public func stopCountingCalories(){
        countingCalories = false
    }
    
    public func setNewHeartRateAverage(currentBPM:Int){
        contBPMRecs+=1
        var newHeartRateAvg:Float = 0
        if contBPMRecs == 1{
            oldBPM = currentBPM
            userHeartRateAvg = Float(currentBPM)
            return
        }
        if(contBPMRecs<3){
             newHeartRateAvg = Float(Float(oldBPM!+currentBPM)/Float(contBPMRecs))
        }else{
             newHeartRateAvg = Float(userHeartRateAvg!*Float(contBPMRecs-1)+Float(currentBPM))/Float(contBPMRecs)
        }
        userHeartRateAvg = newHeartRateAvg
    }
    
    public func getBurnedCalories()->Float{
        //FORMULA: http://fitnowtraining.com/2012/01/formula-for-calories-burned/
        let endCaloriesTimer = NSDate()
        let minutes = Float(endCaloriesTimer.timeIntervalSinceDate(recordingCaloriesTimer!)/60)
        
        var ageFactor:Float = 0
        var weightFactor:Float = 0
        var heartRateFactor:Float = 0
        var minusValue:Float = 0
        if(userGender == Gender.Men){
            ageFactor = 0.2017
            weightFactor =  0.09036
            heartRateFactor = 0.6309
            minusValue = 55.0969
        }
        else{
            ageFactor = 0.074
            weightFactor =  0.05741
            heartRateFactor = 0.4472
            minusValue =  20.4022
        }
        
        let userAgeSum = Float(userAge!)*ageFactor
        let userWeightSum = Float(userWeight!) * weightFactor
        let userHeartRateSum = Float(userHeartRateAvg!) * heartRateFactor
        
        let caloriesCounter = (userAgeSum-userWeightSum+userHeartRateSum-minusValue)*minutes/4.184
        return caloriesCounter
    }
    
}