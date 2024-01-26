//
//  box.swift
//  circleparamvol
//
//  Created by PHYS 440 Rachelle on 1/19/24.
//

import Foundation

@Observable class box{
    
    var length = 0.0
    var width = 0.0
    var height = 0.0
    var surfaceArea = 0.0
    var volume = 0.0
    var perimeterText = ""
    var areaText = ""
    var enableButton = true
    
    /// creates a box of 2-3 dimensions
    /// - Parameters:
    ///   - myLength: length of box
    ///   - myWidth: width of box
    ///   - myHeight: heigh of box
    /// - Returns: boolean true describing successful initialization
    func initBox(myLength: Double, myWidth: Double, myHeight: Double) -> Bool {
        length = myLength
        width = myWidth
        height = myHeight
        
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
    
    //// Calculates the volume of the box using the equation length*width*height
    /// - Returns: an array describing the caluculated volume of the box
    func calcVolume() async -> (Type: String, StringToDisplay: String, Value: Double) {
        volume = length * width * height
        let volumeText = "\(volume.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Volume of Box", StringToDisplay: volumeText, Value: volume)
    }
    
    /// Calculates the surface area of the box using length*width*height
    /// - Returns: an array describing the calculated surface area of the sphere
    func calcSurfaceArea() async -> (Type: String, StringToDisplay: String, Value: Double) {
        surfaceArea = length * width * 2 + length * height * 2 + height * width * 2
        let surfaceAreaText = "\(surfaceArea.formatted(.number.precision(.fractionLength(7))))"
        return (Type: "Surface Area of Box", StringToDisplay: surfaceAreaText, Value: surfaceArea)
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
