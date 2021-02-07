//
//  ImageProvider.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

protocol ImageProvider {
    func name(for type: AnyHashable) -> UIImage?
}

class DefaultImageProvider: ImageProvider {
    var dict: [AnyHashable : String]?
    
    static let defaultValue = "default"
    
    init(dict: [AnyHashable: String]? = nil) {
        self.dict = dict
    }
    
    func name(for type: AnyHashable) -> UIImage? {
        guard let dict = dict, let imageName = dict[type] ?? dict[DefaultImageProvider.defaultValue] else {
            return nil
        }
        
        return UIImage(named: imageName)
    }
}

extension DefaultImageProvider {
    static let galaxyImageDict: [AnyHashable: String] = [
        GalaxyType.elliptical: "ellipticalGalaxy",
        GalaxyType.irregural: "irregularGalaxy",
        GalaxyType.spiral: "spiralGalaxy",
        DefaultImageProvider.defaultValue: "unknownGalaxyType"
    ]
    
    static let starImageDict: [AnyHashable: String] = [
        /* TODO:
         StarStage.oldStar: "oldStarImage",
         StarStage.dwarf: "dwarfStarImage"
        */
        StarStage.youngStar: "youngStarImage",
        StarStage.blackHole: "blackHoleImage",
        DefaultImageProvider.defaultValue: "youngStarImage"
    ]
}
