//
//  GalaxyCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

class GalaxyCreatorHandler: Handler {
    func handle(obj: SpaceObject) {
        guard let universe = obj as? UniverseModel else {
            return
        }
        
        universe.newGalaxy()
    }
    
    func isTime(time: Int) -> Bool {
        return time % 10 == 0
    }
    
    
}