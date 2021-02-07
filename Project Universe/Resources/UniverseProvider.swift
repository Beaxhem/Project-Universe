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
    
    var settingsProvider = SettingsProvider.shared
    
    var timer: TimeProvider = DefaultTimeProvider()
    
    var runTime = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                TimerBarButton.shared.reload(time: self?.runTime ?? 0)
            }
            
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
            self?.runTime += 1 * (self?.settingsProvider.timeAcceleration ?? 1)
        }
        timer.start()
    }
    
    private func runHandlers() {
        (universe as? TimeHandled)?.runHandlers(currentTime: runTime)
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
