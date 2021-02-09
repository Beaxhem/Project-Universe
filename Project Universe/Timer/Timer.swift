//
//  Timer.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 16.01.2021.
//

import UIKit

protocol TimeProvider {
    var handler: (() -> Void)? { get set }
    func start()
    func updateTimeAcceleration()
}

class DefaultTimeProvider: TimeProvider {
    var handler: (() -> Void)? {
        didSet {
            timer?.setEventHandler(handler: handler)
        }
    }
    
    var timer: DispatchSourceTimer?
    
    init() {
        let t = DispatchSource.makeTimerSource()
        let timeInterval = Double(1) / Double(SettingsProvider.shared.timeAcceleration)
        t.schedule(deadline: .now(), repeating: timeInterval)
        timer = t
    }
    
    func start() {
        timer?.resume()
    }
    
    func updateTimeAcceleration() {
        let timeInterval = Double(1) / Double(SettingsProvider.shared.timeAcceleration)
        timer?.schedule(deadline: .now(), repeating: timeInterval)
    }
}
