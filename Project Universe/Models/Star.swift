//
//  Star.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

enum StarType {
    case blackHole
}

enum StarStage {
    case gasCloud
    case protostar
    case tTauri
    case redGiant
    case whiteDwarf
    case redDwarf
}

protocol Star {
    var type: StarType { get }
    var stage: StarStage { get }
    var mass: Double { get }
    var temperature: Double { get }
    var radius: Double { get }
    var luminosity: Double { get }
}

class StarModel: Star {
    var radius: Double
    var luminosity: Double
    var type: StarType
    var stage: StarStage
    var mass: Double
    var temperature: Double
    
    init(radius: Double, luminosity: Double, type: StarType, stage: StarStage, mass: Double, temperature: Double) {
        self.luminosity = luminosity
        self.mass = mass
        self.radius = radius
        self.stage = stage
        self.temperature = temperature
        self.type = type
    }
}
