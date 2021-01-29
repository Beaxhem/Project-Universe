//
//  StarCollectionHeaderView.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class StarCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var galaxyImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    
    var data: Star? {
        didSet {
            configure()
        }
    }
    
    let imageProvider = DefaultImageProvider(dict: DefaultImageProvider.starImageDict)
    
    private func configure() {
        guard let data = data else { return }
        
        galaxyImage?.image = imageProvider.name(for: data.stage.currentState?.value as! StarStage)
        titleLabel?.text = "\((data.stage.currentState!.value as? StarStage)?.rawValue ?? "")"
    }}
