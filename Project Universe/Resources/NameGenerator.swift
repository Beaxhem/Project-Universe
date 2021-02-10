//
//  NameGenerator.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

protocol NameGenerator {
    func generate() -> String
}

class DefaultNameGenerator: NameGenerator {
    private var id: Int = 1
    
    let prefix: String
    
    init(with prefix: String) {
        self.prefix = prefix
    }
    
    func generate() -> String {
        let name = "\(prefix) #\(id)"
        
        id += 1
        
        return name
    }
}


