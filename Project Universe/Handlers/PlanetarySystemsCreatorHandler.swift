//
//  PlanetarySystemsCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

class PlanetarySystemCreatorHandler: Handler {
    func handle(obj: SpaceObject) {
        guard let galaxy = obj as? GalaxyModel else {
            return
        }
        
        galaxy.newPlanetarySystem()
//        print("New planetary system created")
    }
    
    func isTime(time: Int) -> Bool {
        return time % 2 == 0
    }
    
    
}
