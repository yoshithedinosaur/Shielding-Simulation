//
//  NeutronClass.swift
//  Shielding Simulation
//
//  Created by Yoshinobu Fujikake on 2/10/22.
//

import Foundation

class Neutron: ObservableObject {
    
    @Published var meanFreePath = 1.0
    
    var kineticEnergy = 1.0 ///Kinetic energy starts at 100%
    
    ///energyLoss
    ///Internally tracks how much energy is left in the particle
    func energyLoss(energyBefore: Double, percentAbsorption: Double) -> Double {
        kineticEnergy = energyBefore - percentAbsorption //the percent absorption is actually the percent absorption of the initial energy (otherwide the energy will never reach zero)
        
        return max(kineticEnergy, 0.0)
    }
    
}
