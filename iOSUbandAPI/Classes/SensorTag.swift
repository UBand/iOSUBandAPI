//
//  SensorTag.swift
//  SwiftSensorTag
//
//  Created by Anas Imtiaz on 26/01/2015.
//  Copyright (c) 2015 Anas Imtiaz. All rights reserved.
//

import Foundation
import CoreBluetooth


let deviceName = "SensorTag"

// Service UUIDs
let IRTemperatureServiceUUID = CBUUID(string: "F000AA00-0451-4000-B000-000000000000")
let AccelerometerServiceUUID = CBUUID(string: "F000AA10-0451-4000-B000-000000000000")
let HumidityServiceUUID      = CBUUID(string: "F000AA20-0451-4000-B000-000000000000")
let MagnetometerServiceUUID  = CBUUID(string: "F000AA30-0451-4000-B000-000000000000")
let BarometerServiceUUID     = CBUUID(string: "F000AA40-0451-4000-B000-000000000000")
let GyroscopeServiceUUID     = CBUUID(string: "F000AA50-0451-4000-B000-000000000000")

// Characteristic UUIDs
let IRTemperatureDataUUID   = CBUUID(string: "F000AA01-0451-4000-B000-000000000000")
let IRTemperatureConfigUUID = CBUUID(string: "F000AA02-0451-4000-B000-000000000000")
let AccelerometerDataUUID   = CBUUID(string: "F000AA11-0451-4000-B000-000000000000")
let AccelerometerConfigUUID = CBUUID(string: "F000AA12-0451-4000-B000-000000000000")
let HumidityDataUUID        = CBUUID(string: "F000AA21-0451-4000-B000-000000000000")
let HumidityConfigUUID      = CBUUID(string: "F000AA22-0451-4000-B000-000000000000")
let MagnetometerDataUUID    = CBUUID(string: "F000AA31-0451-4000-B000-000000000000")
let MagnetometerConfigUUID  = CBUUID(string: "F000AA32-0451-4000-B000-000000000000")
let BarometerDataUUID       = CBUUID(string: "F000AA41-0451-4000-B000-000000000000")
let BarometerConfigUUID     = CBUUID(string: "F000AA42-0451-4000-B000-000000000000")
let GyroscopeDataUUID       = CBUUID(string: "F000AA51-0451-4000-B000-000000000000")
let GyroscopeConfigUUID     = CBUUID(string: "F000AA52-0451-4000-B000-000000000000")



class SensorTag {
    
    // Pulse Data Variables 
    
    static var BPM:Int=0                           // used to hold the pulse rate
    static var IBI:UInt = 600                       // holds the time between beats, the Inter-Beat Interval
    static var Pulse:Bool = false                  // true when pulse wave is high, false when it's low
    static var QS:Bool = false                     // becomes true when Arduoino finds a beat.
    
    static var rate:[UInt] = [0,0,0,0,0,0,0,0,0,0]  // used to hold last ten IBI values
    static var sampleCounter:CUnsignedLong = 0     // used to determine pulse timing
    static var lastBeatTime:CUnsignedLong = 0      // used to find the inter beat interval
    static var P:UInt = 512                         // used to find peak in pulse wave
    static var T:UInt = 512                         // used to find trough in pulse wave
    static var thresh:UInt = 512                    // used to find instant moment of heart beat
    static var amp:Int = 100                       // used to hold amplitude of pulse waveform
    static var firstBeat:Bool = true               // used to seed rate array so we startup with reasonable BPM
    static var secondBeat:Bool = true              // used to seed rate array so we startup with reasonable BPM
    
    //MARK: Pedometer Variables, related to accelerometer
    static var previousY:Double = 0
    static var currentY:Double = 0
    static var numSteps:Int = 0
    static var treshold:Int = 1300

    
    // Check name of device from advertisement data
    class func sensorTagFound (advertisementData: [NSObject : AnyObject]!) -> Bool {
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? NSString
        return (nameOfDeviceFound == deviceName)
    }
    
    
    // Check if the service has a valid UUID
    class func validService (service : CBService) -> Bool {
        if service.UUID == IRTemperatureServiceUUID || service.UUID == AccelerometerServiceUUID ||
            service.UUID == HumidityServiceUUID || service.UUID == MagnetometerServiceUUID ||
            service.UUID == BarometerServiceUUID || service.UUID == GyroscopeServiceUUID {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Check if the characteristic has a valid data UUID
    class func validDataCharacteristic (characteristic : CBCharacteristic) -> Bool {
        if characteristic.UUID == IRTemperatureDataUUID || characteristic.UUID == AccelerometerDataUUID ||
            characteristic.UUID == HumidityDataUUID || characteristic.UUID == MagnetometerDataUUID ||
            characteristic.UUID == BarometerDataUUID || characteristic.UUID == GyroscopeDataUUID {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Check if the characteristic has a valid config UUID
    class func validConfigCharacteristic (characteristic : CBCharacteristic) -> Bool {
        if characteristic.UUID == IRTemperatureConfigUUID || characteristic.UUID == AccelerometerConfigUUID ||
            characteristic.UUID == HumidityConfigUUID || characteristic.UUID == MagnetometerConfigUUID ||
            characteristic.UUID == BarometerConfigUUID || characteristic.UUID == GyroscopeConfigUUID {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Get labels of all sensors
    class func getSensorLabels () -> [String] {
        let sensorLabels : [String] = [
            "Ambient Temperature",
            "Object Temperature",
            "Accelerometer X",
            "Accelerometer Y",
            "Accelerometer Z",
            "Relative Humidity",
            "Magnetometer X",
            "Magnetometer Y",
            "Magnetometer Z",
            "Gyroscope X",
            "Gyroscope Y",
            "Gyroscope Z"
        ]
        return sensorLabels
    }
    
    
    
    // Process the values from sensor
    
    
    // Convert NSData to array of bytes
    class func dataToSignedBytes16(value : NSData) -> [Int16] {
        let count = value.length
        var array = [Int16](count: count, repeatedValue: 0)
        value.getBytes(&array, length:count * sizeof(Int16))
        return array
    }
    
    class func dataToUnsignedBytes16(value : NSData) -> [UInt16] {
        let count = value.length
        var array = [UInt16](count: count, repeatedValue: 0)
        value.getBytes(&array, length:count * sizeof(UInt16))
        return array
    }
    
    class func dataToSignedBytes8(value : NSData) -> [Int8] {
        let count = value.length
        var array = [Int8](count: count, repeatedValue: 0)
        value.getBytes(&array, length:count * sizeof(Int8))
        return array
    }
    class func dataToUnsignedBytes8(value : NSData) -> [UInt8] {
        let count = value.length
        var array = [UInt8](count: count, repeatedValue: 0)
        value.getBytes(&array, length:count * sizeof(UInt8))
        return array
    }
    
    // Get ambient temperature value
    class func getAmbientTemperature(value : NSData) -> Double {
        let dataFromSensor = dataToUnsignedBytes8(value)
        //let uInt16Value = UInt16(dataFromSensor[3]) << 8 | UInt16(dataFromSensor[2])
        let uInt16Value = Double(Int16(bitPattern: ((UInt16(dataFromSensor[3]) << 8 | UInt16(dataFromSensor[2])))))
        let ambientTemperature = (Double(uInt16Value) * 0.3125)/10
        return ambientTemperature
    }
    
    // Get object temperature value
    class func getObjectTemperature(value : NSData, ambientTemperature : Double) -> Double {
        let dataFromSensor = dataToSignedBytes16(value)
        let Vobj2 = Double(dataFromSensor[0]) * 0.00000015625
        
        let Tdie2 = ambientTemperature + 273.15
        let Tref  = 298.15
        
        let S0 = 6.4e-14
        let a1 = 1.75E-3
        let a2 = -1.678E-5
        let b0 = -2.94E-5
        let b1 = -5.7E-7
        let b2 = 4.63E-9
        let c2 = 13.4
        
        let S = S0*(1+a1*(Tdie2 - Tref)+a2*pow((Tdie2 - Tref),2))
        let Vos = b0 + b1*(Tdie2 - Tref) + b2*pow((Tdie2 - Tref),2)
        let fObj = (Vobj2 - Vos) + c2*pow((Vobj2 - Vos),2)
        let tObj = pow(pow(Tdie2,4) + (fObj/S),0.25)
        
        let objectTemperature = (tObj - 273.15)
        
        return objectTemperature
    }
    
    // Get Accelerometer values
    class func getAccelerometerData(value: NSData) -> [Double] {
        let dataFromSensor = dataToUnsignedBytes8(value)
        print("raw accel:",value)
        let xVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[0]) << 8 | UInt16(dataFromSensor[1])))))
        let yVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[2]) << 8 | UInt16(dataFromSensor[3])))))
        let zVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[4]) << 8 | UInt16(dataFromSensor[5])))))
        return [xVal, yVal, zVal]
    }
    // Get Pulse values
    class func getPulseData(value: NSData) -> UInt {
        //Source: http://stackoverflow.com/questions/32830866/how-in-swift-to-convert-int16-to-two-uint8-bytes
        print("raw pulse:",value)
        let dataFromSensor = dataToUnsignedBytes8(value)
        let signal = UInt16(dataFromSensor[0]) << 8 | UInt16(dataFromSensor[1])
        //print("signal",signal)

        self.sampleCounter += 2                           // keep track of the time in mS with this variable
        var N:UInt
        N = UInt(sampleCounter - lastBeatTime)            // monitor the time since the last beat to avoid noise
        
        //  find the peak and trough of the pulse wave
        if(UInt(signal) < thresh && N > (IBI/5)*3){       // avoid dichrotic noise by waiting 3/5 of last IBI
            if (UInt(signal) < T){                        // T is the trough
                T = UInt(signal)                          // keep track of lowest point in pulse wave
            }
        }
        
        if(UInt(signal) > thresh && UInt(signal) > P){    // thresh condition helps avoid noise
            P = UInt(signal)                              // P is the peak
        }                                                 // keep track of highest point in pulse wave
        
        //  NOW IT'S TIME TO LOOK FOR THE HEART BEAT
        // signal surges up in value every time there is a pulse
        if (N > 250){                                     // avoid high frequency noise
            if ((UInt(signal) > thresh) && (Pulse == false) && (N > (IBI/5)*3) ){
                Pulse = true;                                 // set the Pulse flag when we think there is a pulse
                IBI = UInt(sampleCounter - lastBeatTime)      // measure time between beats in mS
                lastBeatTime = sampleCounter                  // keep track of time for next pulse
                
                if(firstBeat){                                // if it's the first time we found a beat, if firstBeat == TRUE
                    firstBeat = false                         // clear firstBeat flag
                    return 0                                  // IBI value is unreliable so discard it
                }
                if(secondBeat){                               // if this is the second beat, if secondBeat == TRUE
                    secondBeat = false                        // clear secondBeat flag
                    for i in 0..<10{
                        rate[i] = IBI                         // seed the running total to get a realisitic BPM at startup
                    }
                }
                
                // keep a running total of the last 10 IBI values
                var runningTotal:UInt16 = 0                  // clear the runningTotal variable
                
                for i in 0..<9 {                             // shift data in the rate array
                    rate[i] = rate[i+1]                      // and drop the oldest IBI value
                    runningTotal += UInt16(rate[i])          // add up the 9 oldest IBI values
                }
                
                rate[9] = IBI                               // add the latest IBI to the rate array
                runningTotal += UInt16(rate[9])             // add the latest IBI to runningTotal
                runningTotal /= 10                          // average the last 10 IBI values
                BPM = 60000/Int(runningTotal)               // how many beats can fit into a minute? that's BPM!
                QS = true                                   // set Quantified Self flag
                // QS FLAG IS NOT CLEARED INSIDE THIS ISR
            }
        }
        
        if (UInt(signal) < thresh && Pulse == true){        // when the values are going down, the beat is over
            Pulse = false                                   // reset the Pulse flag so we can do it again
            amp = Int(P-UInt(T))                            // get amplitude of the pulse wave
            thresh = UInt(UInt(amp/2) + UInt(T))            // set thresh at 50% of the amplitude
            P = thresh                                      // reset these for next time
            T = thresh
        }
        
        if (N > 2500){                             // if 2.5 seconds go by without a beat
            thresh = 512;                          // set thresh default
            P = 512;                               // set P default
            T = 512;                               // set T default
            lastBeatTime = sampleCounter           // bring the lastBeatTime up to date
            firstBeat = true                       // set these to avoid noise
            secondBeat = true                      // when we get the heartbeat back
        }
        return UInt(BPM)
    }
    
    // Get Relative Humidity
    class func getRelativeHumidity(value: NSData) -> Double {
        let dataFromSensor = dataToUnsignedBytes8(value)
        let humidity = -6 + 125/65536 * Double(dataFromSensor[0])
        return humidity
    }
    
    // Get magnetometer values
    class func getMagnetometerData(value: NSData) -> [Double] {
        let dataFromSensor = dataToSignedBytes16(value)
        let xVal = Double(dataFromSensor[0]) * 2000 / 65536 * -1
        let yVal = Double(dataFromSensor[1]) * 2000 / 65536 * -1
        let zVal = Double(dataFromSensor[2]) * 2000 / 65536
        return [xVal, yVal, zVal]
    }
    
    // Get gyroscope values
    class func getGyroscopeData(value: NSData) -> [Double] {
        let dataFromSensor = dataToUnsignedBytes8(value)
        
        let xVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[0]) << 8 | UInt16(dataFromSensor[1])))))
        let yVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[2]) << 8 | UInt16(dataFromSensor[3])))))
        let zVal = Double(Int16(bitPattern: ((UInt16(dataFromSensor[4]) << 8 | UInt16(dataFromSensor[5])))))

        return [xVal, yVal, zVal]
    }
    
    
    class func getBatteryData(value: NSData) -> Int {
        let dataFromSensor =  dataToUnsignedBytes8(value)
        let batteryLevel = 1 * Int(dataFromSensor[0])
        return batteryLevel
    }
    
    //Compute the steps
    class func computeSteps(x:Double,y:Double,z:Double)->Bool{
        self.currentY = y
        var flagStep:Bool = false
        //print("current Y:",currentY)
        //print("previous Y:",previousY)
        let absResult = abs(currentY-previousY)
        //print("absResult:",absResult)
        if(absResult>Double(treshold)){
            numSteps++
            flagStep = true
            print("STEP")
        }
        self.previousY = y
        return flagStep
    }

}