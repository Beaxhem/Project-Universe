//
//  Randomizable.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

protocol Randomizable: CaseIterable {
    
}

extension Randomizable {
    static func random() -> Self {
        return allCases.randomElement()!
    }
}
