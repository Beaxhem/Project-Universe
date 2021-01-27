//
//  PlanetarySystemsCreatorHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

class PlanetarySystemCreatorHandler: Handler {
    let settingsProvider = SettingsProvider.shared
    
    lazy var timeInterval: Int = {
        return 10 / settingsProvider.timeAcceleration
    }()
    
    func handle(obj: SpaceObject) {
        guard let galaxy = obj as? GalaxyModel else {
            return
        }
        
        galaxy.newPlanetarySystem()
//        print("New planetary system created")
    }
    
    func isTime(time: Int) -> Bool {
        return time % timeInterval == 0
    }
    
    
}
