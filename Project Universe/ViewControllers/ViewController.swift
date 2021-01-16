//
//  ViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class GalaxiesViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var galaxiesCollectionView: UICollectionView?
    
    let galaxiesDataSource = GalaxiesCollectionViewDataSource()
    let galaxiesDelegate = GalaxyCollectionViewDelegateFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGalaxiesCollectionView()
        
        scheduleGalaxyGeneration()
    }

    private func setUpGalaxiesCollectionView() {
        guard let galaxiesCollectionView = galaxiesCollectionView else { return }
        
        galaxiesCollectionView.dataSource = galaxiesDataSource
        galaxiesCollectionView.delegate = galaxiesDelegate
        galaxiesCollectionView.register(GalaxyCollectionViewCell.self, forCellWithReuseIdentifier: GalaxyCollectionViewCell.identifier)
    }
    
    private func scheduleGalaxyGeneration() {
        TimeProvider.current.schedule(timeInterval: 2) { [weak self] t in
            guard let self = self else { return }
            
            let newGalaxy = GalaxyModel(type: GalaxyType.random()!)
            UniverseProvider.current.appendGalaxy(newGalaxy)
            
            let indexPath = IndexPath(row: UniverseProvider.current.galaxiesCount - 1, section: 0)
            self.galaxiesCollectionView?.insertItems(at: [indexPath])
        }
    }
}


