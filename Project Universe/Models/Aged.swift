//
//  Aged.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

protocol Aged {
    var age: Int { get }
    var creationTime: Int? { get set }
}

class DefaultAged {
    var age: Int {
        get {
            UniverseProvider.shared.runTime - (self.creationTime ?? 0)
        }
        set {}
    }
    
    var creationTime: Int?
}
