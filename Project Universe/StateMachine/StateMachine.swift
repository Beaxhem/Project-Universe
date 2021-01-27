//
//  StateMachine.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//


protocol State {
    associatedtype Enum
    var state: Enum { get set }
    var next: Enum? { get set }
}

//protocol StateMachine {
//    var currentState: State? { get set }
//    func next()
//}
