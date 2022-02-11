//
//  SimulateShielding.swift
//  Shielding Simulation
//
//  Created by Yoshinobu Fujikake on 2/10/22.
//

import Foundation

class SimulateShielding: NSObject, ObservableObject {
    let simulator = RandomWalk()
    let particle = Neutron()
    
    @MainActor @Published var positionData = [(xPosition: Double, yPosition: Double)]()
    @Published var percentAbsorption = 0.0
    @Published var yWallBoundaries = [0.0, 0.0]
    @Published var xWallBoundaries = [0.0, 0.0]
    @Published var escapeCount: Int = 0
    
    @MainActor init(withData data: Bool){
        
        super.init()
        
        positionData = []
        
    }
    
    ///simulateShielding
    ///
    ///does the random walk in the wall and keeping track of the places the particle has been
    ///
    func simulateShielding(initialPosition: (xPosition: Double, yPosition: Double)) async -> [(Double, Double)] {
        
        var positionPoints : [(xPosition: Double, yPosition: Double)] = []
        var newPosition = (xPosition: 0.0, yPosition: 0.0)
        var energyRemaining = 1.0 //Start with 100% of its energy
        var stepNumber: Int = 0
        
        positionPoints.append(initialPosition)
        
        while(energyRemaining > 0.0) {
            
            newPosition = simulator.randomWalk(position: positionPoints[stepNumber])
            positionPoints.append(newPosition)
            
            if (newPosition.xPosition <= xWallBoundaries[0] || newPosition.xPosition >= xWallBoundaries[1] || newPosition.yPosition <= yWallBoundaries[0] || newPosition.yPosition >= yWallBoundaries[1]) {
                
                energyRemaining = 0.0
                escapeCount += 1
                
            } else {
                
                stepNumber += 1
                energyRemaining = particle.energyLoss(energyBefore: energyRemaining, percentAbsorption: percentAbsorption)
                
            }
            
        }
        
        await updateData(positionPoints: positionPoints)
        
        return positionPoints
        
    }
    
    @MainActor func updateData(positionPoints: [(xPosition: Double, yPosition: Double)]){
        
        positionData.append(contentsOf: positionPoints)
    }
    
}
