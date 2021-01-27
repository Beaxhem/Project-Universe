//
//  SettingsProvider.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

class SettingsProvider {
    static let shared = SettingsProvider()
    
    var timeAcceleration: Int = 1 {
        didSet {
            if timeAcceleration < 1 {
                timeAcceleration = 1
            }
        }
    }
}
