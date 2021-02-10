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
