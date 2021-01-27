//
//  SpaceObject.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

protocol SpaceObjectDelegate: AnyObject {
    func spaceObjectDidChange(newObj: SpaceObject)
}

protocol SpaceObject: AnyObject {
    var delegate: SpaceObjectDelegate? { get set }
}
