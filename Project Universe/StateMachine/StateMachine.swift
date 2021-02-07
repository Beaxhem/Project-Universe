//
//  StateMachine.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//


protocol State {
    typealias Value = Any
    var value: Value { get set }
    var next: State? { get set }
}

protocol StateMachine {
    var currentState: State? { get set }
}

class DefaultStateMachine: StateMachine {
    var currentState: State?
    
    init(state: State) {
        self.currentState = state
    }
    
    func next() {
        currentState = currentState?.next
    }
}
