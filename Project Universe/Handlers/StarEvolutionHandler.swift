//
//  StarEvolutionHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 29.01.2021.
//

import Foundation

class StarEvolutionHandler: Handler {
    var timeInterval: Int = 30
    
    func handle(obj: SpaceObject) {
        guard let planetarySystem = obj as? PlanetarySystemModel, let star = planetarySystem.star as? StarModel else {
            return
        }
        
        if star.age > timeInterval {
            if let next = star.stage.currentState?.next {
                if next is BlackHoleState {
                    planetarySystem.planets = []
                }
                star.stage.currentState = next
                planetarySystem.star = star
            }
        }
    }
}
