//
//  ContentView.swift
//  circleparamvol
//
//  Created by PHYS 440 Rachelle on 1/19/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var sphereModel = sphere()
    @State private var cubeModel = box()
    @State var radiusString = "0.0"
    
    var body: some View {
    
        VStack{
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Enter Radius", text: $radiusString, onCommit: {self.calculate()})
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
            
            HStack {  //sphere calculations
                VStack{
                    Text("Sphere Volume")
                        .padding(.bottom, 0)
                    Text("\(sphereModel.volume, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                    Text("Sphere Surface Area")
                        .padding(.bottom, 0)
                    
                    Text("\(sphereModel.surfaceArea, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                }
            }
           /* HStack{  //cube calculations
                VStack{
                    Text("Cube Volume")
                        .padding(.bottom, 0)
                    TextField("", text: ( $circleModel.perimeterText))
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom, 30)
                }
                VStack{
                    Text("Cube Surface Area")
                        .padding(.bottom, 0)
                    Text("\(circleModel.perimeter, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
                
                
                
            }
            */
            Button("Calculate", action: {self.calculate()})
                .padding(.bottom)
                .padding()
               // .disabled(circleModel.enableButton == false)
        }
            
        }
        
        func calculate() {
            let myradius = Double(radiusString)!
            let _ = sphereModel.initSphere(myradius: myradius)
            
        }
        
}

#Preview {
    ContentView()
}
