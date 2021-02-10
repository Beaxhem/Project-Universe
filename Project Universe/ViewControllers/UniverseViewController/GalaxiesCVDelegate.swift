//
//  GalaxiesCVDelegate.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

class GalaxiesCVDelegate: SpaceObjectCVDelegateFlowLayout {
    var presenter: UINavigationController?
    weak var galaxiesDataSource: GalaxiesCVDataSource?
    
    init(presenter: UINavigationController? = nil) {
        self.presenter = presenter
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: "GalaxyViewController") as? GalaxyViewController else {
            return
        }
        
        guard let galaxyDataSource = galaxiesDataSource, let galaxy = galaxyDataSource.universe.galaxies[indexPath.item] as? GalaxyModel else {
            return
        }
        
        vc.galaxy = galaxy
        
        presenter?.pushViewController(vc, animated: true)
    }
}
