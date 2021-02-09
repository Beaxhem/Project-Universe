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
    
    var isSpeedUp: Bool = false {
        didSet {
            timeAcceleration = isSpeedUp ? 2 : 1
        }
    }
    lazy var timeAcceleration: Int = 1 {
        didSet {
            delegate?.timeAccelerationChanged()
        }
    }
}
