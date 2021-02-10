//
//  GalaxyViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class GalaxyViewController: SpaceObjectViewController {
    
    @IBOutlet weak var planetarySystemsCollectionView: UICollectionView?
    
    lazy var planetarySystemsCollectionViewDelegate = PlanetarySystemsCVDelegate(presenter: navigationController, galaxy: galaxy)
    lazy var planetarySystemsCollectionViewDataSource = PlanetarySystemsCVDataSource(galaxy: galaxy)
    
    var imageProvider: ImageProvider = DefaultImageProvider(dict: DefaultImageProvider.galaxyImageDict)
    
    var galaxy: Galaxy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UniverseProvider.shared.galaxiesDidChange = universeUpdate
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        universeUpdate()
        
        UniverseProvider.shared.galaxiesDidChange = universeUpdate
    }
    
    private func setupCollectionView() {
        guard let planetaryCollectionView = planetarySystemsCollectionView else { return }
        
        planetaryCollectionView.delegate = planetarySystemsCollectionViewDelegate
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

// MARK: - UICollectionViewDataSource
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
