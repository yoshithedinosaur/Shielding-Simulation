//
//  DrawingView.swift
//  Shielding Simulation
//
//  Created by Yoshinobu Fujikake on 2/11/22.
//

import Foundation
import SwiftUI

struct DrawingView: View {
    
    //@Binding var particlePaths : [(xPosition: Double, yPosition: Double)]
    @Binding var particleEndPositions : [(xPosition: Double, yPosition: Double)]
    
    var body: some View {
        
        ZStack{
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
            
            //ParticlePath(ParticlePoints: particlePaths)
            //    .stroke(Color.red, lineWidth: 1)
            
            ParticleEndPositions(ParticleEndPoints: particleEndPositions)
                //.stroke(Color.red)
                .fill(.red)
        }
        
        
        
    }
    
    
}


func ParticlePath(ParticlePoints: [(xPosition: Double, yPosition:Double)]) -> Path {
    
    //var ParticlePoints : [(xPosition: Double, yPosition:Double)] = []
    
    var path = Path()
    
    if ParticlePoints.isEmpty {
        
        return path
    }
    
    // move to the initial position
    path.move(to: CGPoint(x: 100*ParticlePoints[0].xPosition + 150, y: -(100*ParticlePoints[0].yPosition - 50)+600))
    
    for item in 1..<(ParticlePoints.endIndex)  {
        
        path.addLine(to: CGPoint(x: 100*ParticlePoints[item].xPosition + 150, y: -(100*ParticlePoints[item].yPosition + 50)+600))
        
        
    }
    
    return (path)
    
}

func ParticleEndPositions(ParticleEndPoints: [(xPosition: Double, yPosition:Double)]) -> Path {
    var point = Path()
    
    if ParticleEndPoints.isEmpty {
        
        return point
    }
    
    for item in 1..<(ParticleEndPoints.endIndex)  {
        
        //point.addArc(center: CGPoint(x: 100*ParticleEndPoints[item].xPosition + 150, y: -(100*ParticleEndPoints[item].yPosition + 50)+600), radius: 3, startAngle: Angle.degrees(0.0), endAngle: Angle.degrees(360.0), clockwise: true)
        
        point.addRect( CGRect(x: 100*ParticleEndPoints[item].xPosition + 150, y: -(100*ParticleEndPoints[item].yPosition + 50)+600, width: 3, height: 3))
    }
    
    return point
}

