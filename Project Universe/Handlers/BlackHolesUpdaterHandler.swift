//
//  BlackHolesUpdaterHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

class BlackHolesUpdaterHandler: Handler {
    var timeInterval: Int = 10
    
    func handle(obj: SpaceObject) {
        guard let galaxy = obj as? GalaxyModel, let planetarySystems = galaxy.planetarySystems else {
            return
        }
        
        for idx in 0..<planetarySystems.count {
            if let ps = planetarySystems[idx] as? PlanetarySystem {
                if let star = ps.star, star.isBlackHole {
                    galaxy.planetarySystems?[idx] = ps.star!
                }
            }
        }
    }
    
    
}
