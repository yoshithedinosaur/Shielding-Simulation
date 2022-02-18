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
    
    var positionData = [(xPosition: Double, yPosition: Double)]()
    var percentAbsorption = 0.0
    var yWallBoundaries = [0.0, 0.0]
    var xWallBoundaries = [0.0, 0.0]
    var escapeCount: Int = 0
    var absorbCount: Int = 0
    var endPointsData = [(xPosition: Double, yPosition: Double)]()
    @Published var enableButton = true
    @Published var escapeCountString = ""
    @Published var absorbCountString = ""
    
    @MainActor init(withData data: Bool){
        
        super.init()
        
        positionData = []
        
    }
    
    func calculateSimulation(initialPosition: (xPosition: Double, yPosition: Double)) async {
        
        let positionPoints = await simulateShielding(initialPosition: initialPosition)
        
        await updateData(positionPoints: positionPoints)
        await updateCount(textEsc: "\(escapeCount)", textAbs: "\(absorbCount)")
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
        var endPoints = [(xPosition: Double, yPosition: Double)]()
        
        positionPoints.append((initialPosition.xPosition + 1.0, initialPosition.yPosition))
        
        //positionPoints.append(initialPosition)
        
        while(energyRemaining > 0.0) {
            
            newPosition = simulator.randomWalk(position: positionPoints[stepNumber])
            positionPoints.append(newPosition)
            
            if (newPosition.xPosition <= xWallBoundaries[0] || newPosition.xPosition >= xWallBoundaries[1] || newPosition.yPosition <= yWallBoundaries[0] || newPosition.yPosition >= yWallBoundaries[1]) {
                
                energyRemaining = 0.0
                if (newPosition.xPosition >= xWallBoundaries[1] || newPosition.yPosition <= yWallBoundaries[0] || newPosition.yPosition >= yWallBoundaries[1]){
                    escapeCount += 1 //For out of bound on top, bottom, and right of wall
                } else {
                    absorbCount += 1 //Back scatter counts as absorbed
                }
                
            } else if (energyRemaining > 0.0){
                
                stepNumber += 1
                energyRemaining = particle.energyLoss(energyBefore: energyRemaining, percentAbsorption: percentAbsorption)
                if (energyRemaining <= 0.0) {
                    absorbCount += 1 //Particle energy reaches 0
                }
                
            }
            
            
        }
        
        endPoints.append(newPosition)
        
        await updateEndPointData(endPoints: endPoints)
        
        return positionPoints
        
    }
    
    
    @MainActor func updateData(positionPoints: [(xPosition: Double, yPosition: Double)]){
        
        positionData.append(contentsOf: positionPoints)
        
    }
    
    @MainActor func updateEndPointData(endPoints: [(xPosition: Double, yPosition: Double)]){
        
        endPointsData.append(contentsOf: endPoints)
        
    }
    
    
    @MainActor func updateCount(textEsc: String, textAbs: String){
        
        self.escapeCountString = textEsc
        self.absorbCountString = textAbs
        
    }
    
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
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
    
}
