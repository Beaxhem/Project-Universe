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

class UniverseModel: TimeHandled, Universe {
    
    // MARK: TimeHandled conformation
    override var children: [TimeHandled]? {
        get {
            return galaxies as? [TimeHandled]
        }
        set {}
    }
    
    override var handlers: [Handler]? {
        get {
            [
                GalaxyCreatorHandler(),
                GalaxiesCollapseHandler()
            ]
        }
        set {}
    }
    
    // MARK: Universe conformation
    var galaxies: [Galaxy] = []
    
    let nameGenerator = DefaultNameGenerator(with: "Galaxy")
    
    func newGalaxy() {
        let newGalaxy = GalaxyModel.generate()
        newGalaxy.name = nameGenerator.generate()
        newGalaxy.delegate = self
        galaxies.insert(newGalaxy, at: 0)
    }
}

extension UniverseModel: SpaceObjectDelegate {
    // Galaxies did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        guard let newUniverse = newObj as? UniverseModel else {
            return
        }
        galaxies = newUniverse.galaxies
        
        delegate?.spaceObjectDidChange(newObj: self)
    }
}

