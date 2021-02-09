//
//  PlanetarySystem.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol PlanetarySystemLike {
    var mass: Double { get }
}

protocol PlanetarySystem: PlanetarySystemLike {
    var name: String { get set }
    var star: Star? { get set }
    var planets: [Planet]? { get set }
}

class PlanetarySystemModel: TimeHandled, PlanetarySystem, PlanetarySystemLike {
    
    // MARK: TimeHandled conformation
    override var handlers: [Handler]? {
        get {
            return [
                PlanetsCreatorHandler(),
                StarEvolutionHandler()
            ]
        }
        set {}
    }
    
    // MARK: PlanetarySystem protocol conformation
    var name: String = ""
    var star: Star?
    var planets: [Planet]?
    
    var mass: Double {
        guard let star = star, let planets = planets else {
             return 0
        }
        
        return star.mass + planets.reduce(0, { res, planet in
            return res + planet.mass
        })
    }
    
    let nameGenerator = DefaultNameGenerator(with: "Planet")
    
    init(star: Star) {
        self.star = star
    }
    
    static func generate() -> PlanetarySystemModel {
        return PlanetarySystemModel(star: StarModel.generate())
    }
    
    // Overriding method from TimeHandled because of an extra .star property, which needs to be updated
    override func runHandlers(currentTime: Int) {
        var needsUpdate = false
        let queue = DispatchQueue(label: "com.beaxhem.Project-Universe.universeHandlers", attributes: .concurrent)
        let group = DispatchGroup()
        
        guard let handlers = handlers else { return }
        
        for handler in handlers {
            if handler.isTime(time: currentTime) {
                needsUpdate = true
                
                group.enter()
                queue.sync {
                    handler.handle(obj: self)
                    group.leave()
                }
            }
        }
        
        (star as? StarModel)?.time = currentTime
        
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else { return }
                
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
    }
}
