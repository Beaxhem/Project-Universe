//
//  UniverseProvider.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class UniverseProvider {
    
    static let shared = UniverseProvider(universe: UniverseModel())
    
    var universe: Universe
    
    var galaxiesDidChange: (() -> Void)?
    
    var settingsProvider = SettingsProvider.shared
    
    var timer: TimeProvider = DefaultTimeProvider()
    
    var timerBarButton: TimerBarButton = DefaultTimerBarButton(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
    
    var runTime = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.timerBarButton.reload(time: self?.runTime ?? 0)
            }
            
            runHandlers()
        }
    }
    
    init(universe: UniverseModel) {
        self.universe = universe
        setupDelegates()
       
        setupTimer()
    }
    
    private func setupDelegates() {
        (universe as? UniverseModel)?.delegate = self
        settingsProvider.delegate = self
    }
    
    private func setupTimer() {
        timer.handler = { [weak self] in
            self?.runTime += 1
        }
        timer.start()
    }
    
    private func runHandlers() {
        (universe as? TimeHandled)?.runHandlers(currentTime: runTime)
    }
}

// MARK: -SettingsProviderDelegate
extension UniverseProvider: SettingsProviderDelegate {
    func timeAccelerationChanged() {
        timer.updateTimeAcceleration()
    }
}

// MARK: -SpaceObjectDelegate
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
