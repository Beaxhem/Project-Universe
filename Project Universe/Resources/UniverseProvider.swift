//
//  UniverseProvider.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import Foundation

class UniverseProvider {
    static let shared = UniverseProvider(universe: UniverseModel())
    
    var universe: Universe
    
    var galaxiesDidChange: (() -> Void)?
    
    var timer: TimeProvider = DefaultTimeProvider()
    
    private var runTime = 0 {
        didSet {
            runHandlers()
        }
    }
    
    init(universe: UniverseModel) {
        self.universe = universe
        universe.delegate = self
        
        setupTimer()
    }
    
    private func setupTimer() {
        timer.handler = { [weak self] in
            self?.runTime += 1
        }
        timer.start()
    }
    
    private func runHandlers() {
        (universe as? UniverseModel)?.time = runTime
    }
}

extension UniverseProvider: SpaceObjectDelegate {
    // Universe did change
    func spaceObjectDidChange(newObj: SpaceObject) {
        guard let universe = newObj as? UniverseModel else {
            return
        }
        self.universe = universe
        self.galaxiesDidChange?()
    }
}