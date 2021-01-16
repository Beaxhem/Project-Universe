//
//  GalaxyCollectionViewCell.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class GalaxyCollectionViewCell: UICollectionViewCell {
    static let identifier = "GalaxyCollectionViewCell"
    
    var data: Galaxy? {
        willSet {
            guard let newValue = newValue else { return }
            
            var imageName: String
            
            switch newValue.type {
            case .elliptical:
                imageName = "ellipticalGalaxy"
            case .irregural:
                imageName = "irregularGalaxy"
            case .spiral:
                imageName = "spiralGalaxy"
            default:
                imageName = "unknownGalaxyType"
            }
            
            galaxyImage.image = UIImage(named: imageName)
        }
    }
    
    var galaxyImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "cellBackgroundColor")
        layer.cornerRadius = 8
        
        
        addSubview(galaxyImage)
        
        NSLayoutConstraint.activate([
            galaxyImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            galaxyImage.topAnchor.constraint(equalTo: topAnchor),
            galaxyImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            .init(item: galaxyImage, attribute: .height, relatedBy: .equal, toItem: galaxyImage, attribute: .width, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
