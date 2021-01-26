//
//  ViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 15.01.2021.
//

import UIKit

class UniverseViewController: UIViewController, UICollectionViewDelegate {
    private let spacing: CGFloat = 15
    private let height: CGFloat = 300
    
    @IBOutlet weak var galaxiesCollectionView: UICollectionView?
    
    var universe = UniverseProvider.shared.universe
    
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
        
        galaxiesCollectionView.dataSource = self
        galaxiesCollectionView.delegate = self
        galaxiesCollectionView.register(GalaxyCollectionViewCell.self, forCellWithReuseIdentifier: GalaxyCollectionViewCell.identifier)
    }
}

extension UniverseViewController {
    func galaxiesDidChange() {
        galaxiesCollectionView?.reloadData()
    }
}

extension UniverseViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - spacing * 3 / 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "GalaxyViewController") as? GalaxyViewController else {
            return
        }
        
        let galaxy = universe.galaxies[indexPath.item]
        
        vc.galaxy = galaxy
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UniverseViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return universe.galaxies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalaxyCollectionViewCell.identifier, for: indexPath) as? GalaxyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = universe.galaxies[indexPath.item]
        
        return cell
    }
}
