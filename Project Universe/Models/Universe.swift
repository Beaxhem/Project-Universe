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
        GalaxyCreatorHandler()
    ]
    
    var delegate: SpaceObjectDelegate?
    
    func newGalaxy() {
        let newGalaxy = GalaxyModel.generate()
        newGalaxy.delegate = self
        galaxies.insert(newGalaxy, at: 0)
    }
}

extension UniverseModel: Handled {
    
    func runHandlers() {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        let group = DispatchGroup()
        
        for handler in handlers {
            if handler.isTime(time: time) {
                group.enter()
                utilityQueue.sync {
                    handler.handle(obj: self)
                    group.leave()
                }
            }
        }
        
        for galaxy in galaxies {
            guard let galaxy = galaxy as? GalaxyModel else {
                return
            }
            
            utilityQueue.async { [weak self] in
                galaxy.time = self?.time ?? 0
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.delegate?.spaceObjectDidChange(newObj: self)
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
        UniverseProvider.shared.galaxiesDidChange?()
    }
}

