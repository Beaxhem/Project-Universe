//
//  PlanetarySystemsCVDataSource.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

class PlanetarySystemsCVDataSource {
    var galaxy: Galaxy?
    
    init(galaxy: Galaxy?) {
        self.galaxy = galaxy
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galaxy?.planetarySystems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PlanetarySystemCollectionViewCell.self)", for: indexPath) as? PlanetarySystemCollectionViewCell else {
            fatalError()
        }

        let planetarySystem = galaxy?.planetarySystems?[indexPath.item]
        cell.data = planetarySystem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(GalaxyCollectionHeaderView.self)", for: indexPath) as? GalaxyCollectionHeaderView else {
                fatalError()
            }
            
            view.data = galaxy
            
            return view
        }

        return UICollectionReusableView()
    }
}
