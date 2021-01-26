//
//  Planet.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

enum PlanetType: Randomizable {
    case rocky
    case gasGiant
    case iceGiant
}

protocol Planet {
    var type: PlanetType { get set }
    var mass: Double { get }
    var radius: Double { get }
    
    var satelites: [Satelite] { get set }
}

class PlanetModel: Planet {
    var type: PlanetType
    var mass: Double
    var radius: Double
    
    var satelites: [Satelite] = []
    
    init(type: PlanetType, mass: Double, radius: Double) {
        self.type = type
        self.mass = mass
        self.radius = radius
        
        generateSatelites()
    }
    
    private func generateSatelites() {
        let numberOfSatelites: Int = .random(in: 0...5)
        
        for _ in 0 ..< numberOfSatelites {
            let newSatelite = SateliteModel.generate()
            self.satelites.append(newSatelite)
        }
    }
    
    static func generate() -> PlanetModel {
        let hundredRange: ClosedRange<Double> = 0...100
        return PlanetModel(
            type: .random(),
            mass: .random(in: hundredRange),
            radius: .random(in: hundredRange))
    }
}

