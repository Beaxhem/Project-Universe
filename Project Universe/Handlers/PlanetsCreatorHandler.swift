//
//  PlanetsCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

class PlanetsCreatorHandler: Handler {
    func handle(obj: SpaceObject) {
        guard let planetSystem = obj as? PlanetarySystemModel else {
            return
        }
        
        let newPlanet = PlanetModel.generate()
        
        var planets: [Planet]? = planetSystem.planets
        if planets != nil {
            if planets!.count < 9 {
                planets?.insert(newPlanet, at: 0)
            }
        } else {
            planets = [newPlanet]
        }
        
        planetSystem.planets = planets
        
//        print("New planet created")
    }
    
    func isTime(time: Int) -> Bool {
        return time % 2 == 0
    }
    
    
}
