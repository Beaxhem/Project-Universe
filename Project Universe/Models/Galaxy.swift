//
//  Galaxy.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

enum GalaxyType: CaseIterable {
    case elliptical
    case spiral
    case irregural
    
    static func random() -> GalaxyType? {
        self.allCases.randomElement()
    }
}

protocol Galaxy: SpaceObject {
    var type: GalaxyType { get }
    var age: Int { get set }
    var planetarySystems: [PlanetarySystem]? { get set }
}

class GalaxyModel: SpaceObject, Galaxy {
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    var type: GalaxyType
    var age: Int = 0
    var planetarySystems: [PlanetarySystem]?
    
    let handlers: [Handler] = [
        PlanetarySystemCreatorHandler()
    ]
    
    var delegate: SpaceObjectDelegate?
    
    init(type: GalaxyType) {
        self.type = type
    }
    
    func newPlanetarySystem() {
        let newPlanetSystem = PlanetarySystemModel.generate()
        newPlanetSystem.delegate = self
        if planetarySystems != nil {
            planetarySystems?.insert(newPlanetSystem, at: 0)
        } else {
            planetarySystems = [newPlanetSystem]
        }
    }
    
    static func generate() -> GalaxyModel {
        return GalaxyModel(type: GalaxyType.allCases.randomElement()!)
    }
}

extension GalaxyModel: Handled {
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
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.delegate?.spaceObjectDidChange(newObj: self)
        }
    }
}

extension GalaxyModel: SpaceObjectDelegate {
    // Planetary systems did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        
    }
    
    
}
