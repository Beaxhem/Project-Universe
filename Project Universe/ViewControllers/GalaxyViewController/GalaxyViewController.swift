//
//  GalaxyViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class GalaxyViewController: UIViewController {
    private let spacing: CGFloat = 15
    private let height: CGFloat = 320
    
    @IBOutlet weak var planetarySystemsCollectionView: UICollectionView?
    
    var imageProvider: ImageProvider = DefaultImageProvider(dict: DefaultImageProvider.galaxyImageDict)
    
    var galaxy: Galaxy?
    
    override func viewDidLoad() {
        UniverseProvider.shared.galaxiesDidChange = universeUpdate
    
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        guard let planetaryCollectionView = planetarySystemsCollectionView else { return }
        
        planetaryCollectionView.delegate = self
        planetaryCollectionView.dataSource = self
        
        let cellID = "\(PlanetarySystemCollectionViewCell.self)"
        planetaryCollectionView.register(
            UINib(nibName: cellID, bundle: nil),
            forCellWithReuseIdentifier: cellID)
    }
}

extension GalaxyViewController {
    func universeUpdate() {
        let range = Range(uncheckedBounds: (0, planetarySystemsCollectionView?.numberOfSections ?? 0))
        let indexSet = IndexSet(integersIn: range)
        planetarySystemsCollectionView?.reloadSections(indexSet)
    }
}

extension GalaxyViewController: UICollectionViewDataSource {
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

extension GalaxyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - spacing * 3 / 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
}
