//
//  TimerBarButton.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

class TimerBarButton: UIView {
    static let shared = TimerBarButton(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
    
    let timeProvider = UniverseProvider.shared
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 34)
        label.text = "0"
        label.textAlignment = .center
        label.layer.cornerRadius = 17
        label.textColor = .systemBlue
        label.layer.masksToBounds = true
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemBlue.cgColor
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func reload(time: Int) {
        let minutes = time / 60
        let seconds = time % 60
        
        let pattern = "\(minutes < 10 ? "0\(minutes)" : "\(minutes)"):\(seconds < 10 ? "0\(seconds)" : "\(seconds)")"
        
        timeLabel.text = pattern
    }
}
