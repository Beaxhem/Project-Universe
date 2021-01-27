//
//  Handler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

protocol Handler {
    var timeInterval: Int { get set }
    func handle(obj: SpaceObject)
}

extension Handler {
    func isTime(time: Int) -> Bool {
        return time % timeInterval == 0
    }
}
