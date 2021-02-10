//
//  PlanetarySystemViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class PlanetarySystemViewController: SpaceObjectViewController {
    
    @IBOutlet weak var planetsCollectionView: UICollectionView?

    let planetsCollectionViewDelegate = PlanetsCVDelegate()
    lazy var planetsCollectionViewDataSource = PlanetsCVDataSource(planetarySystem: planetarySystem)
    
    var planetarySystem: PlanetarySystem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UniverseProvider.shared.galaxiesDidChange = onUpdate
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        guard let planetsCollectionView = planetsCollectionView else { return }
        planetsCollectionView.delegate = planetsCollectionViewDelegate
        planetsCollectionView.dataSource = planetsCollectionViewDataSource
        planetsCollectionView.register(UINib(nibName: "\(PlanetCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PlanetCollectionViewCell.self)")
    }
}

extension PlanetarySystemViewController {
    func onUpdate() {
        let range = Range(uncheckedBounds: (0, planetsCollectionView?.numberOfSections ?? 0))
        let indexSet = IndexSet(integersIn: range)
        planetsCollectionView?.reloadSections(indexSet)
    }
}

// MARK: - UICollectionViewDataSource
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
