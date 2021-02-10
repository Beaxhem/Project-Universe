//
//  GalaxiesCVDataSource.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

protocol GalaxiesCVDataSource: UICollectionViewDataSource {
    var universe: Universe { get set}
}

class DefaultGalaxiesCVDataSource: NSObject, GalaxiesCVDataSource {
    var universe: Universe
    
    init(universe: Universe) {
        self.universe = universe
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return universe.galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GalaxyCollectionViewCell.self)", for: indexPath) as? GalaxyCollectionViewCell else {
            fatalError()
        }
        
        cell.data = universe.galaxies[indexPath.item]
        
        return cell
    }
}
