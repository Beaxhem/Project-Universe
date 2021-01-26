//
//  Timer.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 16.01.2021.
//

import UIKit

class TimeProvider {
    
    static let current = TimeProvider()
    
    func schedule(timeInterval: TimeInterval, completion: @escaping (_ timer: Timer) -> Void) {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: completion)
    }
}
