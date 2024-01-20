//
//  box.swift
//  circleparamvol
//
//  Created by PHYS 440 Rachelle on 1/19/24.
//

import Foundation

@Observable class box{
    
    var halfLength = 0.0
    var surfaceArea = 0.0
    var volume = 0.0
    //var perimeterText = ""
    //var areaText = ""
    //var enableButton = true
    
    func initSphere(myhalfLength: Double) -> Bool {
        halfLength = myhalfLength
        return true
    }
    
    func calcVolume() -> Double {
        var fullLength = 2 * halfLength
        volume = pow(fullLength, 3)
        return volume
    }
    
    func calcSurfaceArea() -> Double {
        var fullLength = 2 * halfLength
        surfaceArea = fullLength * fullLength * 6
        return surfaceArea
    }
    
}
