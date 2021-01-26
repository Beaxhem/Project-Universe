//
//  GalaxyCollectionReusableView.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class GalaxyCollectionHeaderView: UICollectionReusableView {
    var data: Galaxy? {
        didSet {
            configure()
        }
    }
    
    let imageProvider = DefaultImageProvider(dict: DefaultImageProvider.galaxyImageDict)
    
    @IBOutlet weak var galaxyImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    
    private func configure() {
        guard let data = data else { return }
        
        galaxyImage?.image = imageProvider.name(for: data.type)
        titleLabel?.text = data.name
    }
}
