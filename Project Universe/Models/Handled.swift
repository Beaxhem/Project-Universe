//
//  Handled.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import Foundation

protocol Handled: SpaceObject {
    var handlers: [Handler]? { get set }
    func runHandlers()
}

class TimeHandled: Handled, SpaceObject {
    var time: Int = 0 {
        didSet {
            runHandlers()
        }
    }
    
    var handlers: [Handler]? = nil
    weak var delegate: SpaceObjectDelegate?
    var children: [TimeHandled]? = nil
    
    func runHandlers() {
        var needsUpdate = false
        let queue = DispatchQueue(label: "com.beaxhem.Project-Universe.universeHandlers", attributes: .concurrent)
        let group = DispatchGroup()
        
        guard let handlers = handlers else {
            return
        }
        
        for handler in handlers {
            if handler.isTime(time: time) {
                needsUpdate = true
                
                group.enter()
                queue.sync {
                    handler.handle(obj: self)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            if needsUpdate {
                guard let self = self else {
                    return
                }
                self.delegate?.spaceObjectDidChange(newObj: self)
            }
        }
        
        passCurrentTimeToChildren()
    }
    
    private func passCurrentTimeToChildren() {
        guard let children = children else {
            return
        }
        
        for child in children {
            child.time = self.time
        }
    }
}
