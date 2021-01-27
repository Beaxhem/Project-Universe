//
//  GalaxyCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

class GalaxyCreatorHandler: Handler {
    var timeInterval: Int = 10
    
    func handle(obj: SpaceObject) {
        guard let universe = obj as? UniverseModel else {
            return
        }
        
        universe.newGalaxy()
        
//        print("New galaxy created")
    }
}
