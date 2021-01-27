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
        titleLabel?.text = "\(planet.type)"
        descriptionLabel?.text = "\(planet.satelites.count)"
    }
}
