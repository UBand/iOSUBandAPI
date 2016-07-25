//
//  UBandServices.swift
//  UBandAPI
//
//  Created by Karen Gonzalez on 6/22/16.
//  Copyright © 2016 Hunabsys. All rights reserved.
//

import Foundation

enum UBandService{
    
    enum Service:String{
        case AccelGyro     = "f000aa10-0451-4000-b000-000000000000"
        case Magnetometer  = "f000aa30-0451-4000-b000-000000000000"
        case Pulse         = "f000aab0-0451-4000-b000-000000000000"
        case Galvanic      = "f000aaa0-0451-4000-b000-000000000000"
        case Temperature   = "f000aa00-0451-4000-b000-000000000000"
        case Battery       = "f000aac0-0451-4000-b000-000000000000"
    }
    
    enum DataChar:String{
        case AccelGyro     = "f000aa11-0451-4000-b000-000000000000"
        case Magnetometer  = "f000aa31-0451-4000-b000-000000000000"
        case Pulse         = "f000aab1-0451-4000-b000-000000000000"
        case Galvanic      = "f000aaa1-0451-4000-b000-000000000000"
        case Temperature   = "f000aa01-0451-4000-b000-000000000000"
        case Battery       = "f000aac1-0451-4000-b000-000000000000"
    }
    
    enum ConfigChar:String{
        case AccelGyro     = "f000aa12-0451-4000-b000-000000000000"
        case Magnetometer  = "f000aa32-0451-4000-b000-000000000000"
        case Pulse         = "f000aab2-0451-4000-b000-000000000000"
        case Galvanic      = "f000aaa2-0451-4000-b000-000000000000"
        case Temperature   = "f000aa02-0451-4000-b000-000000000000"
        case Battery       = "f000aac2-0451-4000-b000-000000000000"
    }
    
    enum ConfigPeriod:String{
        case AccelGyro     = "f000aa13-0451-4000-b000-000000000000"
        case Magnetometer  = "f000aa33-0451-4000-b000-000000000000"
        case Pulse         = "f000aab3-0451-4000-b000-000000000000"
        case Galvanic      = "f000aaa3-0451-4000-b000-000000000000"
        case Temperature   = "f000aa03-0451-4000-b000-000000000000"
        case Battery       = "f000aac3-0451-4000-b000-000000000000"
    }
    
}