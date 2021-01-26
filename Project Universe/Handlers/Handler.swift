//
//  Handler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

protocol Handler {
    func handle(obj: SpaceObject)
    func isTime(time: Int) -> Bool
}
