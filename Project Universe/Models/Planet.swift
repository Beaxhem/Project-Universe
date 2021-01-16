//
//  Planet.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

enum PlanetType {
    case rocky
    case gasGiant
    case iceGiant
}

protocol Planet {
    var type: PlanetType { get }
    var mass: Double { get }
    var temperature: Double { get }
    var radius: Double { get }
    
    var satelites: [Planet]? { get }
}

class PlanetModel: Planet {
    var type: PlanetType
    var mass: Double
    var temperature: Double
    var radius: Double
    
    var satelites: [Planet]?
    
    init(type: PlanetType, mass: Double, temperature: Double, radius: Double) {
        self.type = type
        self.mass = mass
        self.temperature = temperature
        self.radius = radius
    }
}

