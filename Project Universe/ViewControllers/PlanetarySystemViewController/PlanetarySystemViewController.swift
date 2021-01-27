//
//  PlanetarySystemViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class PlanetarySystemViewController: UIViewController {
    
    private let spacing: CGFloat = 15
    private let height: CGFloat = 320
    
    @IBOutlet weak var planetsCollectionView: UICollectionView?

    var planetarySystem: PlanetarySystem?
    
    override func viewDidLoad() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        guard let planetsCollectionView = planetsCollectionView else { return }
        planetsCollectionView.delegate = self
        planetsCollectionView.dataSource = self
        planetsCollectionView.register(UINib(nibName: "\(PlanetCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PlanetCollectionViewCell.self)")
    }
}

extension PlanetarySystemViewController: UICollectionViewDataSource {
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

extension PlanetarySystemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - spacing * 3 / 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let planetarySystem = plane[indexPath.item] else {
//            return
//        }
//        
//        guard let vc = storyboard?.instantiateViewController(identifier: "\(PlanetarySystemViewController.self)") as? PlanetarySystemViewController else {
//            return
//        }
//        
//        vc.planetarySystem = planetarySystem
//        
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
