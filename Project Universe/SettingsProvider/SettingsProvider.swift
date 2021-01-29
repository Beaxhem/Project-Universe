//
//  SettingsProvider.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

protocol SettingsProviderDelegate: AnyObject {
    func timeAccelerationChanged()
}

class SettingsProvider {
    
    static let shared = SettingsProvider()
    
    weak var delegate: SettingsProviderDelegate?
        
    var timeAcceleration: Int = 2 {
        didSet {
            delegate?.timeAccelerationChanged()
        }
    }
}
