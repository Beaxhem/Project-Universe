//
//  PlanetarySystem.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol PlanetarySystem {
    var name: String { get set }
    var star: Star { get }
    var planets: [Planet]? { get set }
}

class PlanetarySystemModel: SpaceObject, PlanetarySystem {
    
    var name: String
    var star: Star
    var planets: [Planet]?
    
    private let nameGenerator = DefaultNameGenerator(with: "Planet system")
    
    var delegate: SpaceObjectDelegate?
    
    init(star: Star) {
        self.name = nameGenerator.generate()
        self.star = star
    }
    
    static func generate() -> PlanetarySystemModel {
        return PlanetarySystemModel(star: StarModel.generate())
    }
}
