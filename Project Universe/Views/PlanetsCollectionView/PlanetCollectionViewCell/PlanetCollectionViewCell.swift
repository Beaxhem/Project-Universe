//
//  PlanetCollectionViewCell.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class PlanetCollectionViewCell: UICollectionViewCell {
    
    var data: Planet? {
        didSet {
            configure()
        }
    }
    
    @IBOutlet weak var planetImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    private func configure() {
        guard let planet = data else { return }
        titleLabel?.text = "\(planet.name)"
        descriptionLabel?.text = getDescription()
    }
    
    private func getDescription() -> String? {
        guard let planet = data else {
            return nil
        }
        
        let description = """
        Num. of satelites: \(planet.satelites.count)\n\
        Mass: \(String(format: "%.1f", planet.mass))\n\
        Radius: \(String(format: "%.1f", planet.radius))\n\
        Type: \(planet.type.rawValue)
        """
        
        return description
    }
}
