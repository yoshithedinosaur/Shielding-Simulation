//
//  RandomWalk.swift
//  Shielding Simulation
//
//  Created by Yoshinobu Fujikake on 2/10/22.
//

import Foundation

class RandomWalk: ObservableObject {
    
    let particle = Neutron() ///Defining that the particle beam is neutrons
    
    ///Random walk class should define functions that:
    /// - Picks a direction
    /// - Walk the mean free path
    /// - Keep track of the path taken
    
    func randomWalk(position: (xPosition: Double, yPosition: Double)) -> (Double, Double) {
        
        let distance = particle.meanFreePath
        
        var deflectAngle = 0.0
        var newPosition = position
        
        deflectAngle = Double.random(in: 0.0...(2*Double.pi))
        
        newPosition.xPosition = position.xPosition + (distance * cos(deflectAngle))
        newPosition.yPosition = position.yPosition + (distance * sin(deflectAngle))
        
        return newPosition
    }
    
}
