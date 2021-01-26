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
    
    var timer: DispatchSourceTimer?
    private var runTime = 0 {
        didSet {
            runHandlers()
        }
    }
    
    init(universe: UniverseModel) {
        self.universe = universe
        
        setupTimer()
    }
    
    private func setupTimer() {
        (universe as? UniverseModel)?.delegate = self
        let t = DispatchSource.makeTimerSource()
        
        t.schedule(deadline: .now(), repeating: 1)
        t.setEventHandler { [weak self] in
            self?.runTime += 1
        }
        timer = t
        timer?.resume()
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
