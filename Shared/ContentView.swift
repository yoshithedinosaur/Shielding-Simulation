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
            }
        
            DrawingView()
                .padding()
                .aspectRatio(1, contentMode: .fit)
                .drawingGroup()
            Spacer()
        }
        
    }
    
    
    func calcualteShielding() async {
        for numberOfNeutrons in 1...Int(numberOfNeutronsString)! {
            await simulated.simulateShielding(initialPosition: (0,Double(heightOfBeamString)!))
        }
        numberEscapedString
        numberAbsorbedString
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
