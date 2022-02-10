//
//  ContentView.swift
//  Shared
//
//  Created by Yoshinobu Fujikake on 2/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var placeholderString = ""
    
    // Set up GUI
    var body: some View {
        
        VStack(alignment: .center) {
            Text("Number of neutrons")
                .font(.callout)
                .bold()
            TextField("# neutrons", text: $placeholderString)
                .padding()
        }
        
        VStack(alignment: .center) {
            Text("Energy loss")
                .font(.callout)
                .bold()
            TextField("% loss", text: $placeholderString)
                .padding()
        }
        
        VStack(alignment: .center) {
            Text("Number Escaped")
                .font(.callout)
                .bold()
            TextField("# Escaped", text: $placeholderString)
                .padding()
        }
        
        VStack(alignment: .center) {
            Text("Number Absorbed")
                .font(.callout)
                .bold()
            TextField("# Absorbed", text: $placeholderString)
                .padding()
        }
        
        VStack(alignment: .center) {
            Text("Percent Escaped")
                .font(.callout)
                .bold()
            TextField("% Escaped", text: $placeholderString)
                .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
