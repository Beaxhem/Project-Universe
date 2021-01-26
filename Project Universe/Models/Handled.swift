//
//  Handled.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 26.01.2021.
//

protocol Handled {
    var time: Int { get set }
    func runHandlers()
}
