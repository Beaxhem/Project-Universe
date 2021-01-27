//
//  PlanetarySystemsCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

class PlanetarySystemCreatorHandler: Handler {
    
    var timeInterval: Int = 10
    
    func handle(obj: SpaceObject) {
        guard let galaxy = obj as? GalaxyModel else {
            return
        }
        
        galaxy.newPlanetarySystem()
//        print("New planetary system created")
    }
}
