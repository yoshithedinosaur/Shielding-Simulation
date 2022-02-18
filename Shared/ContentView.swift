//
//  ContentView.swift
//  Shared
//
//  Created by Yoshinobu Fujikake on 2/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var numberOfNeutronsString = "1235"
    @State var energyLossString = "0.10"
    @State var numberEscapedString = ""
    @State var numberAbsorbedString = ""
    @State var percentEscString = ""
    @State var heightOfBeamString = "4.0"
    @ObservedObject var simulated = SimulateShielding(withData: true)
    
    // Set up GUI
    var body: some View {
        HStack{
            VStack{
                VStack(alignment: .center) {
                    Text("Number of neutrons")
                        .font(.callout)
                        .bold()
                    TextField("# neutrons", text: $numberOfNeutronsString)
                        .padding()
                }
                
                VStack(alignment: .center) {
                    Text("Height of beam")
                        .font(.callout)
                        .bold()
                    TextField("Beam height", text: $heightOfBeamString)
                        .padding()
                }
        
                VStack(alignment: .center) {
                    Text("Energy loss")
                        .font(.callout)
                        .bold()
                    TextField("% loss", text: $energyLossString)
                        .padding()
                }
        
                VStack(alignment: .center) {
                    Text("Number Escaped")
                        .font(.callout)
                        .bold()
                    TextField("# Escaped", text: $numberEscapedString)
                        .padding()
                }
        
                VStack(alignment: .center) {
                    Text("Number Absorbed")
                        .font(.callout)
                        .bold()
                    TextField("# Absorbed", text: $numberAbsorbedString)
                        .padding()
                }
        
                VStack(alignment: .center) {
                    Text("Percent Escaped")
                        .font(.callout)
                        .bold()
                    TextField("% Escaped", text: $percentEscString)
                        .padding()
                }
                
                Button("Calculate", action: {Task.init{await self.calculateShielding()}})
                    .padding()
                    .disabled(simulated.enableButton == false)
                
                Button("Clear", action: {self.clear()})
                    .padding(.bottom, 5.0)
                    .disabled(simulated.enableButton == false)
                
                if (!simulated.enableButton){
                    
                    ProgressView()
                }
            }
        
//            DrawingView(particlePaths: $simulated.positionData)
//                .padding()
//                .aspectRatio(1, contentMode: .fit)
//                .drawingGroup()
//            Spacer()
            
            DrawingView(particleEndPositions: $simulated.endPointsData)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            Spacer()
        }
        
    }
    
    
    func calculateShielding() async {
        
        simulated.setButtonEnable(state: false)
        
        simulated.percentAbsorption = Double(energyLossString)!
        simulated.xWallBoundaries = [0.0,5.0]
        simulated.yWallBoundaries = [0.0,5.0]
        
        for _ in 1...Int(numberOfNeutronsString)! {
            await simulated.calculateSimulation(initialPosition: (0,Double(heightOfBeamString)!))
        }
        numberEscapedString = simulated.escapeCountString
        numberAbsorbedString = simulated.absorbCountString
        
        let percentEscaped = Double(numberEscapedString)! / Double(numberOfNeutronsString)!
        
        percentEscString = "\(percentEscaped)"
        
        
        simulated.setButtonEnable(state: true)
    }
    
    
    func clear(){
        
        numberAbsorbedString = ""
        numberEscapedString = ""
        percentEscString =  ""
        simulated.escapeCount = 0
        simulated.absorbCount = 0
        simulated.positionData = []
        simulated.endPointsData = []
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
