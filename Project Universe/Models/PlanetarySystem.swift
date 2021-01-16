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

class PlanetarySystemModel: PlanetarySystem {
    
    var star: Star
    var planets: [Planet]?
    
    init(star: Star) {
        self.star = star
    }
}
