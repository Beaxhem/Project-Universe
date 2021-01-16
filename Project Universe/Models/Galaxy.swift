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

protocol Galaxy {
    var type: GalaxyType { get }
    var age: Int { get set }
    var planetarySystems: [PlanetarySystem]? { get set }
}

class GalaxyModel: Galaxy {
    var type: GalaxyType
    var age: Int = 0
    var planetarySystems: [PlanetarySystem]?
    
    init(type: GalaxyType) {
        self.type = type
    }
}
