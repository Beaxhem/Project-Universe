//
//  GalaxyViewController.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

import UIKit

class GalaxyViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel?
    
    var galaxy: Galaxy? {
        didSet {
            configure()
        }
    }
    
    let handlers: [Handler] = [
        
    ]
    
    override func viewDidLoad() {
        configure()
        
        UniverseProvider.shared.galaxiesDidChange = universeUpdate
    }
    
    private func configure() {
        guard let galaxy = galaxy else {
            return
        }
        
        testLabel?.text = "\(galaxy.planetarySystems?.count ?? 0)"
    }
}

extension GalaxyViewController {
    func universeUpdate() {
        configure()
    }
}
