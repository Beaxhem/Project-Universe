//
//  Galaxy.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

enum GalaxyType: Randomizable {
    case elliptical
    case spiral
    case irregural
}

protocol Galaxy: SpaceObject {
    var name: String { get set }
    var type: GalaxyType { get }
    var age: Int { get }
    var planetarySystems: [PlanetarySystem]? { get set }
    
    var mass: Double { get }
}

class GalaxyModel: SpaceObject, Galaxy {
    var name: String = ""
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    var type: GalaxyType
    var age: Int {
        get {
            self.time - (self.creationTime ?? 0)
        }
        set {
            
        }
    }
    var creationTime: Int?
    var planetarySystems: [PlanetarySystem]?
    var mass: Double {
        planetarySystems?.reduce(Double(0), { res, ps in
            return res + ps.mass
        }) ?? 0
    }
    
    var handlers: [Handler] = [
        PlanetarySystemCreatorHandler()
    ]
    
    weak var delegate: SpaceObjectDelegate?
    
    let nameGenerator = DefaultNameGenerator(with: "Planet system")
    
    init(type: GalaxyType) {
        self.type = type
        self.creationTime = UniverseProvider.shared.runTime
    }
    
    func newPlanetarySystem() {
        let newPlanetSystem = PlanetarySystemModel.generate()
        newPlanetSystem.name = nameGenerator.generate()
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
        
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else {
                    return
                }
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
        
        guard let planetarySystems = planetarySystems else { return }
        for system in planetarySystems {
            (system as? PlanetarySystemModel)?.time = self.time
        }
    }
}

extension GalaxyModel: SpaceObjectDelegate {
    // Planetary systems did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        guard let newGalaxy = newObj as? GalaxyModel else { return }
        
        self.planetarySystems = newGalaxy.planetarySystems
        
        delegate?.spaceObjectDidChange(newObj: self)
    }
}

extension GalaxyModel: Equatable {
    static func == (lhs: GalaxyModel, rhs: GalaxyModel) -> Bool {
        return lhs.type == rhs.type && lhs.age == rhs.age && lhs.name == rhs.name && lhs.creationTime == rhs.creationTime
    }
    
    static func != (lhs: GalaxyModel, rhs: GalaxyModel) -> Bool {
        return lhs.type != rhs.type && lhs.age != rhs.age && lhs.name != rhs.name && lhs.creationTime != rhs.creationTime
    }
}
