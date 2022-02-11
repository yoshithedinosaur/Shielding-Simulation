//
//  DrawingView.swift
//  Shielding Simulation
//
//  Created by Yoshinobu Fujikake on 2/11/22.
//

import Foundation
import SwiftUI

struct DrawingView: View {
    
    var body: some View {
        
        Path { path in
            path.move(to: CGPoint(x: 150, y: 50))
            path.addLine(to: CGPoint(x: 650, y: 50))
            path.addLine(to: CGPoint(x: 650, y: 550))
            path.addLine(to: CGPoint(x: 150, y: 550))
            path.addLine(to: CGPoint(x: 150, y: 50))
        }
        .stroke(Color.black, lineWidth: 1)
        .frame(width: 700, height: 600)
        .background(Color.white)
    }
}
