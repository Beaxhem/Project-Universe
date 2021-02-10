//
//  GalaxiesCVDelegate.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

class GalaxiesCVDelegate: SpaceObjectCVDelegateFlowLayout {
    var presenter: UINavigationController?
    var universe: Universe
    
    init(presenter: UINavigationController? = nil, universe: Universe) {
        self.presenter = presenter
        self.universe = universe
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: "GalaxyViewController") as? GalaxyViewController else {
            return
        }
        
        let galaxy = universe.galaxies[indexPath.item] as! GalaxyModel
        vc.galaxy = galaxy
        
        presenter?.pushViewController(vc, animated: true)
    }
}
