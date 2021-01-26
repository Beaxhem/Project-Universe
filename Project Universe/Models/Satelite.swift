//
//  Satelite.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

protocol Satelite {
    var name: String { get set }
    var mass: Double { get set }
}

class SateliteModel: Satelite {
    var name: String = ""
    var mass: Double
    
    init(mass: Double) {
        self.mass = mass
    }
    
    static func generate() -> SateliteModel {
        let hundredRange: ClosedRange<Double> = 1...100
        return SateliteModel(mass: .random(in: hundredRange))
    }
}
