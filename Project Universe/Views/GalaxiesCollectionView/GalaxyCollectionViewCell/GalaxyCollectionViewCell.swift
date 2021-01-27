//
//  GalaxyCollectionViewCell.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class GalaxyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    private let imageProvider = DefaultImageProvider(dict: DefaultImageProvider.galaxyImageDict)
    
    var data: Galaxy? {
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
        
        let image = imageProvider.name(for: data.type)
        imageView?.image = image
        titleLabel?.text = data.name
        descriptionLabel?.text = getDescription()
    }
    
    private func getDescription() -> String? {
        guard let galaxy = data else {
            return nil
        }
        
        let description = """
        Num. of PS: \(galaxy.planetarySystems?.count ?? 0)\n\
        Age: \(galaxy.age) sec.\n\
        Type: \(galaxy.type)\n\
        Mass: \(String(format: "%.1f", galaxy.mass))
        """
        
        
        return description
    }
}
