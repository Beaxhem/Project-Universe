//
//  PlanetsCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

class PlanetsCreatorHandler: Handler {
    var timeInterval: Int = 10
    
    func handle(obj: SpaceObject) {
        guard let planetSystem = obj as? PlanetarySystemModel else {
            return
        }
        
        if planetSystem.star.stage.currentState is BlackHoleState {
            planetSystem.planets = []
            return
        }
        
        let newPlanet = PlanetModel.generate()
        newPlanet.name = planetSystem.nameGenerator.generate()
        
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
}
