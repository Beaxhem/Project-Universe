//
//  Universe.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

protocol Universe {
    var galaxies: [Galaxy] { get set }
}

class UniverseModel: SpaceObject, Universe {
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    
    var galaxies: [Galaxy] = []
    let handlers: [Handler] = [
        GalaxyCreatorHandler(),
        GalaxiesCollapseHandler()
    ]
    
    var delegate: SpaceObjectDelegate?
    
    let nameGenerator = DefaultNameGenerator(with: "Galaxy")
    
    func newGalaxy() {
        let newGalaxy = GalaxyModel.generate()
        newGalaxy.name = nameGenerator.generate()
        newGalaxy.delegate = self
        galaxies.insert(newGalaxy, at: 0)
    }
}

extension UniverseModel: Handled {
    
    func runHandlers() {
        var needsUpdate = false
        
        let queue = DispatchQueue(label: "com.beaxhem.Project-Universe.universeHandlers", attributes: .concurrent)
            
//        let queue = DispatchQueue.global(qos: .utility)
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
        
        for galaxy in galaxies {
            guard let galaxy = galaxy as? GalaxyModel else {
                return
            }
            
            galaxy.time = self.time
        }
        
       
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else { return }
                
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
        
    }
}

extension UniverseModel: SpaceObjectDelegate {
    // Galaxies did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        guard let newUniverse = newObj as? UniverseModel else {
            return
        }
        galaxies = newUniverse.galaxies
        
        delegate?.spaceObjectDidChange(newObj: self)
    }
}

