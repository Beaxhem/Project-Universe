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
        
        var planets = planetSystem.planets ?? []
        let newPlanet = PlanetModel.generate()
        
        planets.insert(newPlanet, at: 0)
        
        planetSystem.planets = planets
    }
    
    func isTime(time: Int) -> Bool {
        return time % 10 == 0
    }
    
    
}
