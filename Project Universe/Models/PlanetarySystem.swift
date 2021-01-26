//
//  PlanetarySystem.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol PlanetarySystem {
    var star: Star { get }
    var planets: [Planet]? { get set }
}

class PlanetarySystemModel: SpaceObject, PlanetarySystem {
    
    var star: Star
    var planets: [Planet]?
    
    var delegate: SpaceObjectDelegate?
    
    init(star: Star) {
        self.star = star
    }
    
    static func generate() -> PlanetarySystemModel {
        return PlanetarySystemModel(star: StarModel.generate())
    }
}
