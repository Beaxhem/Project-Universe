//
//  Handled.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import Foundation

protocol Handled {
    var handlers: [Handler]? { get set }
    func runHandlers(currentTime: Int)
}

class TimeHandled: DefaultAged, Handled, SpaceObject {
    var handlers: [Handler]? = nil
    weak var delegate: SpaceObjectDelegate?
    var children: [TimeHandled]? = nil
    
    func runHandlers(currentTime: Int) {
        var needsUpdate = false
        let queue = DispatchQueue(label: "com.beaxhem.Project-Universe.universeHandlers", attributes: .concurrent)
        let group = DispatchGroup()
        
        guard let handlers = handlers else {
            return
        }
        
        for handler in handlers {
            if handler.isTime(time: currentTime) {
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
        
        passCurrentTimeToChildren(time: currentTime)
    }
    
    private func passCurrentTimeToChildren(time: Int) {
        guard let children = children else {
            return
        }
        
        for child in children {
            child.runHandlers(currentTime: time)
        }
    }
}
