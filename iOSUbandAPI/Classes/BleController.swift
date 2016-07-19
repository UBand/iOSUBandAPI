//
//  BleController.swift
//  UBandAPI
//
//  Created by hunabsys on 7/14/15.
//  Copyright (c) 2015 Hunabsys. All rights reserved.
//

import Foundation
import CoreBluetooth
class BleController: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var central : CBCentralManager!
    var uband : CBPeripheral!
    var bpm:UInt = 0
    var ubandApi : UBandAPI!
    
    let DEVICE_NAME = "U-Band"
    
    init(ubandApi: UBandAPI){
        super.init()
        central = CBCentralManager(delegate: self, queue: nil, options: nil)
        self.ubandApi = ubandApi
    }
    
    func connectToUbandPeripheral(uband:CBPeripheral){
        self.uband = uband
        central.connectPeripheral(uband, options: nil)
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state != .PoweredOn {
            return
        }
        central.scanForPeripheralsWithServices(nil,options:nil)
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //print(peripheral.name)
        if let _ = peripheral.name {
            if (peripheral.name?.rangeOfString("^U-Band.*",options: .RegularExpressionSearch)) != nil{
                //print("Found")
                //print(peripheral.description)
                //print(peripheral.identifier) // identifier is a UUID that iOS computes from the MAC
                ubandApi.addDiscoveredUBandPeripheral(peripheral)
                //self.uband = peripheral
                //central.connectPeripheral(uband, options: nil)
            }
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        uband.delegate = self
        uband.discoverServices(nil)
        ubandApi.notifyPeripheralConnectionStatus(true,error: nil)
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        ubandApi.notifyUBandDisconnected()
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //print(error)
        ubandApi.notifyPeripheralConnectionStatus(false,error:error)
    }
    
    func centralManager(central: CBCentralManager!, didRetrieveConnectedPeripherals peripherals: [AnyObject]!) {
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for service in peripheral.services! {
            //print(service.UUID)
            if (service.UUID == CBUUID(string: UBandService.Service.Accelerometer.rawValue) ||
                service.UUID == CBUUID(string: UBandService.Service.Pulse.rawValue) ||
                service.UUID == CBUUID(string: UBandService.Service.Gyroscope.rawValue) ||
                service.UUID == CBUUID(string: UBandService.Service.Temperature.rawValue) ||
                service.UUID == CBUUID(string: UBandService.Service.Battery.rawValue) ||
                service.UUID == CBUUID(string: UBandService.Service.Galvanic.rawValue)
                ){
                self.uband.discoverCharacteristics(nil, forService: service as CBService)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        switch service.UUID{
            
            case CBUUID(string: UBandService.Service.Accelerometer.rawValue):
                 validateCharacteristicsForService(service.characteristics!,
                                                   characteristicConfigChar: UBandService.ConfigChar.Accelerometer,
                                                   characteristicDataChar: UBandService.DataChar.Accelerometer)
                 break;
            case CBUUID(string: UBandService.Service.Gyroscope.rawValue):
                 validateCharacteristicsForService(service.characteristics!,
                                                   characteristicConfigChar: UBandService.ConfigChar.Gyroscope,
                                                   characteristicDataChar: UBandService.DataChar.Gyroscope)
                 break;
            
            case CBUUID(string: UBandService.Service.Pulse.rawValue):
                 validateCharacteristicsForService(service.characteristics!,
                                                   characteristicConfigChar: UBandService.ConfigChar.Pulse,
                                                   characteristicDataChar: UBandService.DataChar.Pulse)
                 break;
            
            case CBUUID(string: UBandService.Service.Temperature.rawValue):
                 validateCharacteristicsForService(service.characteristics!,
                                                  characteristicConfigChar: UBandService.ConfigChar.Temperature,
                                                  characteristicDataChar: UBandService.DataChar.Temperature)
                 break;
            
            case CBUUID(string: UBandService.Service.Battery.rawValue):
                validateCharacteristicsForService(service.characteristics!,
                                                  characteristicConfigChar: UBandService.ConfigChar.Battery,
                                                  characteristicDataChar: UBandService.DataChar.Battery)
                break;
            
            case CBUUID(string: UBandService.Service.Galvanic.rawValue):
                 validateCharacteristicsForService(service.characteristics!,
                                                  characteristicConfigChar: UBandService.ConfigChar.Galvanic,
                                                  characteristicDataChar: UBandService.DataChar.Galvanic)
                 break;
            
            default: break
                 //print("None valid service")
        }
    }
    
    func validateCharacteristicsForService(characteristics:[CBCharacteristic],characteristicConfigChar:UBandService.ConfigChar,characteristicDataChar:UBandService.DataChar){
        for characteristic in characteristics {
            //print(characteristic)
            if characteristic.UUID == CBUUID(string: characteristicConfigChar.rawValue){
                //print("Receive Values Activated")
                //                TODO: Error
                //                self.uband.writeValue(NSData(bytes: [0x01], length: 1), forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithResponse)
                self.uband.writeValue(NSData(bytes: "\u{1}", length: 1), forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithResponse)
            } else if characteristic.UUID == CBUUID(string: characteristicDataChar.rawValue){
                self.uband.setNotifyValue(true, forCharacteristic: characteristic)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //print("DATA: @", characteristic.value)
        //print("UUID: ", characteristic.UUID.UUIDString)
        switch characteristic.UUID{
            
            case CBUUID(string: UBandService.DataChar.Pulse.rawValue):
                self.bpm = SensorTag.getPulseData(characteristic.value!)
                if self.bpm > 0 {
                    self.ubandApi.setHeartRateData(self.bpm)
                }
            
            case CBUUID(string: UBandService.DataChar.Gyroscope.rawValue):
                 let allValues = SensorTag.getGyroscopeData(characteristic.value!)
                 let gyroX = Float(allValues[0])
                 let gyroY = Float(allValues[1])
                 let gyroZ = Float(allValues[2])
                 self.ubandApi.setGyroscopeData(gyroX, obtainedY: gyroY, obtainedZ: gyroZ)
            
            case CBUUID(string: UBandService.DataChar.Temperature.rawValue):
                let temperature = Float(SensorTag.getAmbientTemperature(characteristic.value!))
                //let objTemperature = SensorTag.getObjectTemperature(characteristic.value!, ambientTemperature: temperature)
                self.ubandApi.setTemperatureData(temperature)
            
            case CBUUID(string: UBandService.DataChar.Battery.rawValue):
                 let batteryLevel = SensorTag.getBatteryData(characteristic.value!)
                 self.ubandApi.setBatteryLevelData(batteryLevel)
            
            case CBUUID(string: UBandService.DataChar.Accelerometer.rawValue):
                let allValues = SensorTag.getAccelerometerData(characteristic.value!)
                let accelerometerX = allValues[0]
                let accelerometerY = allValues[1]
                let accelerometerZ = allValues[2]
                if(SensorTag.computeSteps(accelerometerX, y: accelerometerY, z: accelerometerZ)){
                    self.ubandApi.setNewStep()
                }
                self.ubandApi.setAccelerometerData(Float(accelerometerX), y: Float(accelerometerY), z: Float(accelerometerZ))
            
            case CBUUID(string: UBandService.DataChar.Galvanic.rawValue):
                let sweat = Float(SensorTag.getRelativeHumidity(characteristic.value!))
                self.ubandApi.setSweatingData(sweat)
            
            default:break
                //print("None valid characteristic")
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        //print("Updated")
        //print(error)
    }
    
    
    
    
    
}