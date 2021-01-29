//
//  PlanetarySystem.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol PlanetarySystem {
    var name: String { get set }
    var star: Star { get }
    var planets: [Planet]? { get set }
    
    var mass: Double { get }
}

class PlanetarySystemModel: SpaceObject, PlanetarySystem {
    var name: String = ""
    var star: Star
    var planets: [Planet]?
    
    var mass: Double {
        star.mass + (planets?.reduce(0, { res, planet in
            return res + planet.mass
        }) ?? 0)
    }
    
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    
    let nameGenerator = DefaultNameGenerator(with: "Planet")
    
    let handlers: [Handler] = [
        PlanetsCreatorHandler(),
        StarEvolutionHandler()
    ]
    
    weak var delegate: SpaceObjectDelegate?
    
    init(star: Star) {
        self.star = star
    }
    
    static func generate() -> PlanetarySystemModel {
        return PlanetarySystemModel(star: StarModel.generate())
    }
}

extension PlanetarySystemModel: Handled {
    func runHandlers() {
        var needsUpdate = false
        let queue = DispatchQueue(label: "com.beaxhem.Project-Universe.universeHandlers", attributes: .concurrent)
        let group = DispatchGroup()
        
        for handler in handlers {
            if handler.isTime(time: time) {
                needsUpdate = true
                
                group.enter()
                queue.sync {
                    handler.handle(obj: self)
                    group.leave()
                }
            }
        }
        
        (star as? StarModel)?.time = time
        
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else { return }
                
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
        
        
    }
}
