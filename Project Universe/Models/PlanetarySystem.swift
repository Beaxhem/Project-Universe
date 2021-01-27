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
}

class PlanetarySystemModel: SpaceObject, PlanetarySystem {
    var name: String = ""
    var star: Star
    var planets: [Planet]?
    
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    
    let handlers: [Handler] = [
        PlanetsCreatorHandler()
    ]
    
    var delegate: SpaceObjectDelegate?
    
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
                queue.async {
                    handler.handle(obj: self)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else { return }
                
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
    }
}
