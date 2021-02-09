//
//  SpaceObjectViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 07.02.2021.
//

import UIKit

class SpaceObjectViewController: UIViewController {
    private let spacing: CGFloat = 15
    private let height: CGFloat = 320
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let timerBarButton = UniverseProvider.shared.timerBarButton as? UIView else {
            return
        }
        
        let timerButton = UIBarButtonItem(customView: timerBarButton)
        
        navigationItem.rightBarButtonItem = timerButton
    }
}

extension SpaceObjectViewController: UICollectionViewDelegateFlowLayout {
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
