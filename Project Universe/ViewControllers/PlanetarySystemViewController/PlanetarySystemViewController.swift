//
//  PlanetarySystemViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class PlanetarySystemViewController: SpaceObjectViewController {
    
    @IBOutlet weak var planetsCollectionView: UICollectionView?

    private let planetsCollectionViewDelegate = PlanetsCVDelegate()
    private lazy var planetsCollectionViewDataSource: PlanetsCVDataSource = DefaultPlanetsCVDataSource(planetarySystem: planetarySystem)
    
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
    private func onUpdate() {
        let range = Range(uncheckedBounds: (0, planetsCollectionView?.numberOfSections ?? 0))
        let indexSet = IndexSet(integersIn: range)
        planetsCollectionView?.reloadSections(indexSet)
    }
}
