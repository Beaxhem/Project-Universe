//
//  PlanetarySystemCollectionViewCell.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class PlanetarySystemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    private let imageProvider = DefaultImageProvider(dict: DefaultImageProvider.galaxyImageDict)
    
    var data: PlanetarySystem? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        guard let data = data else {
            return
        }
        
        
//        imageView?.image = image
        titleLabel?.text = data.name
        descriptionLabel?.text = getDescription()
    }
    
    private func getDescription() -> String? {
        guard let planetSystem = data else {
            return nil
        }
        
        let description = """
        Num. of planets: \(planetSystem.planets?.count ?? 0)\n\
        Mass: \(String(format: "%.1f", planetSystem.mass) )\n
        """
        
        return description
    }
}

