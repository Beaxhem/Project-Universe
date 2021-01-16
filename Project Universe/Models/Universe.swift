//
//  Universe.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol Universe {
    var galaxies: [Galaxy] { get set }
}

class UniverseModel: Universe {
    var galaxies: [Galaxy] = []
}

class UniverseProvider {
    static let current = UniverseProvider(universe: UniverseModel())
    
    private var universe: Universe
    
    var galaxiesCount: Int {
        universe.galaxies.count
    }
    
    init(universe: Universe) {
        self.universe = universe
    }
    
    func getGalaxies() -> [Galaxy] {
        return universe.galaxies
    }
    
    func getGalaxy(at index: Int) -> Galaxy? {
        return universe.galaxies[index]
    }
    
    func appendGalaxy(_ galaxy: Galaxy) {
        universe.galaxies.append(galaxy)
    }
}
