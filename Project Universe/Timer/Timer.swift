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
        t.schedule(deadline: .now(), repeating: 1)
        timer = t
    }
    
    func start() {
        timer?.resume()
    }
    
}
