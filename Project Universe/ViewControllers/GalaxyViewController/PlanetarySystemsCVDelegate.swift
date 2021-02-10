//
//  PlanetarySystemsCollectionViewDelegate.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

class PlanetarySystemsCVDelegate: SpaceObjectCVDelegateFlowLayout {
    var presenter: UINavigationController?
    var galaxy: Galaxy?
    
    init(presenter: UINavigationController? = nil, galaxy: Galaxy?) {
        self.presenter = presenter
        self.galaxy = galaxy
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let planetarySystem = galaxy?.planetarySystems?[indexPath.item] as? PlanetarySystem else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "\(PlanetarySystemViewController.self)") as? PlanetarySystemViewController else {
            return
        }
        
        vc.planetarySystem = planetarySystem
        
        presenter?.pushViewController(vc, animated: true)
    }
}
