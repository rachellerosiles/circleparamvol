//
//  circleparamvolTests.swift
//  circleparamvolTests
//
//  Created by PHYS 440 Rachelle on 1/19/24.
//

import XCTest

final class circleparamvolTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class. For when the function exits, such as autosave
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    /// Tests surface area of the sphere
    func testSphereSurfaceArea() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let mysphere = sphere()
        let radius = 3.0
        let _ = mysphere.initSphere(myradius: radius)
        let area = await mysphere.calcSurfaceArea()
        
        XCTAssertEqual(area.Value, 113.0973355292, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    /// Tests volume of sphere
    func testSphereVolume() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let mysphere = sphere()
        let radius = 2.0
        let _ = mysphere.initSphere(myradius: radius)
        let volume = await mysphere.calcVolume()
        
        XCTAssertEqual(volume.Value, 33.51032163829, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
   
    
    /// Tests cube surface area
    func testCubeSurfaceArea() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let myCube = box()
        let radius = 2.45
        let _ = myCube.initBox(myLength: 2*radius, myWidth: 2*radius, myHeight: 2*radius)
        let area = await myCube.calcSurfaceArea()
        
        XCTAssertEqual(area.Value, 144.06, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    /// Tests cube volume
    func testCubeVolume() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let myCube = box()
        let radius = 2.45
        let _ = myCube.initBox(myLength: 2*radius, myWidth: 2*radius, myHeight: 2*radius)
        let volume = await myCube.calcVolume()
        
        XCTAssertEqual(volume.Value, 117.649, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }

     
    func testPerformanceExample() throws {
        // This is an example of a performance test case. Measure for speed
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
