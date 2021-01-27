//
//  Star.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import Foundation

class YoungStarState: State {

    var value: Value = "Young star"
    var next: State? = OldStarState()
    
}

class OldStarState: State {
    var value: Value = "Old star"
    
    var next: State? = FinalStarState()
}

class FinalStarState: State {
    var value: Value = ""
    
    var next: State? = nil
}

enum StarStage: String, Randomizable {
    case youngStar = "Young star"
    case oldStar = "Old star"
    case dwarf = "Dwarf"
    case blackHole = "Black hole"
}

protocol Star {
    var stage: StarStage { get }
    var mass: Double { get }
    var temperature: Double { get }
    var radius: Double { get }
    var luminosity: Double { get }
}

class StarModel: Star {
    var radius: Double
    var luminosity: Double
    var stage: StarStage
    var mass: Double
    var temperature: Double
    
    var stateMachine = DefaultStateMachine(state: YoungStarState())
    
    init(radius: Double, luminosity: Double, stage: StarStage, mass: Double, temperature: Double) {
        self.luminosity = luminosity
        self.mass = mass
        self.radius = radius
        self.stage = stage
        self.temperature = temperature
    }
    
    static func generate() -> StarModel {
        let hundredRange: ClosedRange<Double> = 1...100
        return StarModel(radius: .random(in: hundredRange), luminosity: .random(in: hundredRange), stage: .random(), mass: .random(in: hundredRange), temperature: .random(in: hundredRange))
    }
}
