//
//  GalaxiesCollectionViewDataSource.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class GalaxiesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var universe = UniverseProvider.current
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return universe.galaxiesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalaxyCollectionViewCell.identifier, for: indexPath) as? GalaxyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = universe.getGalaxy(at: indexPath.item)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}
