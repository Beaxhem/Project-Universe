//
//  ViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class UniverseViewController: SpaceObjectViewController {

    @IBOutlet weak var galaxiesCollectionView: UICollectionView?
    
    private lazy var galaxiesCollectionViewDelegate = GalaxiesCVDelegate(
        presenter: navigationController,
        universe: universe)
    private lazy var galaxiesCollectionViewDataSource = GalaxiesCVDataSource(universe: universe)
    
    private var universe = UniverseProvider.shared.universe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGalaxiesCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        galaxiesDidChange()
        
        UniverseProvider.shared.galaxiesDidChange = galaxiesDidChange
    }
    
    private func setUpGalaxiesCollectionView() {
        guard let galaxiesCollectionView = galaxiesCollectionView else { return }
        
        galaxiesCollectionView.dataSource = galaxiesCollectionViewDataSource
        galaxiesCollectionView.delegate = galaxiesCollectionViewDelegate
        galaxiesCollectionView.register(UINib(nibName: "\(GalaxyCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(GalaxyCollectionViewCell.self)")
    }
}

extension UniverseViewController {
    private func galaxiesDidChange() {
        let range = Range(uncheckedBounds: (0, galaxiesCollectionView?.numberOfSections ?? 0))
        let indexSet = IndexSet(integersIn: range)
        galaxiesCollectionView?.reloadSections(indexSet)
    }
}
