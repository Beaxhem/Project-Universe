//
//  TimerBarButton.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import UIKit

protocol TimerBarButton {
    func reload(time: Int)
}

class DefaultTimerBarButton: UIView, TimerBarButton {
    private lazy var timeProvider = UniverseProvider.shared
    
    private let button: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeTimeSpeed), for: .touchUpInside)
        
        return button
    }()
    
    private let timeLabel: UILabel = {
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
        addSubview(button)
        
        button.addSubview(timeLabel)
        
        let isSpeedUp = SettingsProvider.shared.isSpeedUp
        
        timeLabel.backgroundColor = isSpeedUp ? .systemBlue : .clear
        timeLabel.textColor = isSpeedUp ? .label : .systemBlue
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            timeLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: button.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor),
        ])
    }
    
    @objc func changeTimeSpeed() {
        SettingsProvider.shared.isSpeedUp.toggle()
        configure()
    }
    
    func reload(time: Int) {
        let minutes = time / 60
        let seconds = time % 60
        
        let pattern = "\(minutes < 10 ? "0\(minutes)" : "\(minutes)"):\(seconds < 10 ? "0\(seconds)" : "\(seconds)")"
        
        timeLabel.text = pattern
    }
}
