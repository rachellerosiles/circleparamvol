//
//  sphere.swift
//  circleparamvol
//
//  Created by PHYS 440 Rachelle on 1/19/24.
//

import Foundation

@Observable class sphere{
    
    var radius = 0.0
    var surfaceArea = 0.0
    var volume = 0.0
    var perimeterText = ""
    var areaText = ""
    var enableButton = true
    
    /// Initializes 3D sphere object and contains the threading
    /// - Parameter myradius: radius of the sphere, type double
    /// - Returns: boolean value true when created
    func initSphere(myradius: Double) -> Bool {
        radius = myradius
        
        Task{
            
            await setButtonEnable(state: false)
            
            let returnedResults = await withTaskGroup(
                of: (Type: String, StringToDisplay: String, Value: Double).self, /* this is the return from the taskGroup*/
                returning: [(Type: String, StringToDisplay: String, Value: Double)].self, /* this is the return from the result collation */
                body: { taskGroup in  /*This is the body of the task*/
                
                // We can use `taskGroup` to spawn child tasks here.
                
                taskGroup.addTask { let surfaceArea = await self.calcSurfaceArea()
                    
                    return surfaceArea  /* this is the return from the taskGroup*/}
                
                taskGroup.addTask { let volumeResult = await self.calcVolume()
                    
                    return volumeResult  /* this is the return from the taskGroup*/}
                
                
                // Collate the results of all child tasks
                var combinedTaskResults :[(Type: String, StringToDisplay: String, Value: Double)] = []
                for await result in taskGroup {
                    
                    combinedTaskResults.append(result)
                }
                
                return combinedTaskResults  /* this is the return from the result collation */
                
            })
            
            //Do whatever processing that you need with the returned results of all of the child tasks here.
            
            // Sort the results based upon of the result so that the Area returns first
            
            let sortedCombinedResults = returnedResults.sorted(by: { $0.0 < $1.0 })
            
            print(returnedResults)
            print(sortedCombinedResults)
            
            await setButtonEnable(state: true)
            
        }
        return true
    }
    
    /// Calculates the volume of the sphere using the equation 4/3*pi* r^3
    /// - Returns: an array describing the caluculated volume of the sphere
    func calcVolume() async -> (Type: String, StringToDisplay: String, Value: Double) {
        volume = 4/3 * Double.pi * pow(radius, 3)
        let volumeText = "\(volume.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Volume of Sphere", StringToDisplay: volumeText, Value: volume)
    }
    
    /// Calculates the surface area of the sphere using 4* pi * r^2
    /// - Returns: an array describing the calculated surface area of the sphere
    func calcSurfaceArea() async -> (Type: String, StringToDisplay: String, Value: Double) {
        surfaceArea = 4 * Double.pi * pow(radius, 2)
        let surfaceAreaText = "\(surfaceArea.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Surface Area of Sphere", StringToDisplay: surfaceAreaText, Value: surfaceArea)
    }
    
    /// Executes on main thread
    /// - Parameter state: updates state of button
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    /// updateArea
    /// Executes on the main thread
    /// - Parameter areaTextString: Text describing the value of the area
    @MainActor func updateArea(areaTextString: String){
        areaText = areaTextString
    }
    
    /// retrieves surface area
    /// - Parameter areaValue: double displaying value of surface area
    @MainActor func newSurfaceAreaValue(areaValue: Double){
        self.surfaceArea = areaValue
    }
    
    /// retrieves volume
    /// - Parameter volumeValue: double value displaying value of volume
    @MainActor func newVolumeValue(volumeValue: Double){
        self.volume = volumeValue
    }
    
    /// updatePerimeter
    /// Executes on the main thread
    /// - Parameter perimeterTextString: Text describing the value of the perimeter
    @MainActor func updatePerimeter(perimeterTextString:String){
        perimeterText = perimeterTextString
    }
    
}
