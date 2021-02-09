//
//  Galaxy.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

enum GalaxyType: Randomizable {
    case elliptical
    case spiral
    case irregural
}

protocol Galaxy: Aged, SpaceObject {
    var name: String { get set }
    var type: GalaxyType { get }
    var planetarySystems: [PlanetarySystemLike]? { get set }
    
    var mass: Double { get }
}

class GalaxyModel: TimeHandled, Galaxy {
    
    // MARK: TimeHandled conformation
    override var children: [TimeHandled]? {
        get {
            return planetarySystems as? [TimeHandled]
        }
        set {}
    }
    
    override var handlers: [Handler]? {
        get {
            return [
                PlanetarySystemCreatorHandler(),
                BlackHolesUpdaterHandler(),
            ]
        }
        set {}
    }
    
    // MARK: Galaxy protocol conformation
    var name: String = ""
    var type: GalaxyType
    var planetarySystems: [PlanetarySystemLike]?
    
    var mass: Double {
        planetarySystems?.reduce(Double(0), { res, ps in
            return res + ps.mass
        }) ?? 0
    }
    
    let nameGenerator = DefaultNameGenerator(with: "Planet system")
    
    init(type: GalaxyType) {
        self.type = type
    }
}

extension GalaxyModel {
    func newPlanetarySystem() {
        let newPlanetSystem = PlanetarySystemModel.generate()
        newPlanetSystem.name = nameGenerator.generate()
        newPlanetSystem.delegate = self
        
        if planetarySystems != nil {
            planetarySystems?.insert(newPlanetSystem, at: 0)
        } else {
            planetarySystems = [newPlanetSystem]
        }
    }
    
    static func generate() -> GalaxyModel {
        return GalaxyModel(type: GalaxyType.allCases.randomElement()!)
    }
}

// MARK: - SpaceObjectDelegate
extension GalaxyModel: SpaceObjectDelegate {
    // Planetary systems did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        guard let newGalaxy = newObj as? GalaxyModel else { return }
        
        self.planetarySystems = newGalaxy.planetarySystems
        
        delegate?.spaceObjectDidChange(newObj: self)
    }
}
