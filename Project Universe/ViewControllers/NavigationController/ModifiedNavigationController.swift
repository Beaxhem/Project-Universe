//
//  ModifiedNavigationController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class ModifiedNavigationController: UINavigationController {
    
    let timeProvider = UniverseProvider.shared
    
    lazy var timeButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        
        button.title = "\(timeProvider.runTime)"
        
        return button
    }()
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        navigationItem.rightBarButtonItem = timeButton
    }
}
