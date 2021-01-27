//
//  Collection.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import Foundation

extension Collection {
    func sample(_ count : UInt) -> [Element] {
        let sampleCount = Swift.min(numericCast(count), self.count)

        var elements = Array(self)
        var samples : [Element] = []
        
        while samples.count < sampleCount {
            let idx = (0..<elements.count).randomElement()!
            samples.append(elements.remove(at: idx))
        }
        
        return samples
    }
}
