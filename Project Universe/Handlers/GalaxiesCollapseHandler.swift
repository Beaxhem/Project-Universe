//
//  GalaxiesCollapseHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

class GalaxiesCollapseHandler: Handler {
    var timeInterval: Int = 30
    
    func handle(obj: SpaceObject) {
        guard let universe = obj as? UniverseModel else {
            return
        }
        
        var galaxies = universe.galaxies.shuffled()
        
        guard let galaxyOne = galaxies.popLast()?.planetarySystems, let galaxyTwo = galaxies.popLast()?.planetarySystems else {
            return
        }
        
        let newGalaxy = GalaxyModel.generate()
        
        newGalaxy.name = universe.nameGenerator.generate()
        newGalaxy.planetarySystems = galaxyOne + galaxyTwo
        
        galaxies.insert(newGalaxy, at: 0)
        
        universe.galaxies = galaxies
    }
}
