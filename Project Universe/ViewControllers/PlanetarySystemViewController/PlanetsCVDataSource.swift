//
//  PlanetsCVDataSource.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 10.02.2021.
//

import UIKit

protocol PlanetsCVDataSource: UICollectionViewDataSource {
    var planetarySystem: PlanetarySystem? { get set }
}

class DefaultPlanetsCVDataSource: NSObject, PlanetsCVDataSource {
    var planetarySystem: PlanetarySystem?
    
    init(planetarySystem: PlanetarySystem?) {
        self.planetarySystem = planetarySystem
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetarySystem?.planets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PlanetCollectionViewCell.self)", for: indexPath) as? PlanetCollectionViewCell else {
            fatalError()
        }

        let planet = planetarySystem?.planets?[indexPath.item]
        cell.data = planet
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(StarCollectionHeaderView.self)", for: indexPath) as? StarCollectionHeaderView else {
                fatalError()
            }
            
            view.data = planetarySystem?.star
            
            return view
        }

        return UICollectionReusableView()
    }
}
