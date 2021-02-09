//
//  Star.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

class YoungStarState: State {
    var value: Value = StarStage.youngStar
    var next: State? = OldStarState()
}

class OldStarState: State {
    var value: Value = StarStage.oldStar
    
    var next: State? = drand48() > 0.5 ? BlackHoleState() : DwarfStarState()
}

class DwarfStarState: State {
    var value: Value = StarStage.dwarf
    
    var next: State? = nil
}

class BlackHoleState: State {
    var value: Value = StarStage.blackHole
    
    var next: State? = nil
}

enum StarStage: String {
    case youngStar = "Young star"
    case oldStar = "Old star"
    case dwarf = "Dwarf"
    case blackHole = "Black hole"
}

protocol Star: PlanetarySystemLike {
    var mass: Double { get }
    var temperature: Double { get }
    var radius: Double { get }
    var luminosity: Double { get }
    
    var stage: StateMachine { get set }
    
    var isBlackHole: Bool { get }
}

class StarModel: TimeHandled, Star, PlanetarySystemLike {

    var time: Int = 0
    var age: Int {
        get {
            self.time - (self.creationTime ?? 0)
        }
        set { }
    }
    var creationTime: Int?
    
    var radius: Double
    var luminosity: Double
    var mass: Double
    var temperature: Double
    
    var stage: StateMachine = DefaultStateMachine(state: YoungStarState())
    
    var isBlackHole: Bool {
        return stage.currentState?.value as? StarStage == .blackHole
    }
    
    init(radius: Double, luminosity: Double, mass: Double, temperature: Double) {
        self.luminosity = luminosity
        self.mass = mass
        self.radius = radius
        self.temperature = temperature
    }
    
    static func generate() -> StarModel {
        let hundredRange: ClosedRange<Double> = 1...100
        
        return StarModel(
            radius: .random(in: hundredRange),
            luminosity: .random(in: hundredRange),
            mass: .random(in: hundredRange),
            temperature: .random(in: hundredRange))
    }
}
