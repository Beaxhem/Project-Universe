//
//  GalaxyCollectionViewDelegateFlowLayout.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 16.01.2021.
//

import UIKit

class GalaxyCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    private let spacing: CGFloat = 15
    private let height: CGFloat = 300
    
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
