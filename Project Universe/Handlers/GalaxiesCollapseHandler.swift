//
//  GalaxiesCollapseHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

import Foundation

class GalaxiesCollapseHandler: Handler {
    var timeInterval: Int = 30
    
    func handle(obj: SpaceObject) {
        guard let universe = obj as? UniverseModel, let allGalaxies = universe.galaxies as? [GalaxyModel] else {
            return
        }

        var oldEnoughGalaxiesIndices: [Int] = []
        
        for (index, galaxy) in allGalaxies.enumerated() {
            if galaxy.age > 3 {
                oldEnoughGalaxiesIndices.append(index)
            }
        }

        guard oldEnoughGalaxiesIndices.count >= 2 else {
            return
        }
        
        var shuffledIndices = oldEnoughGalaxiesIndices.shuffled()
        guard let firstIndex = shuffledIndices.popLast(), let secondIndex = shuffledIndices.popLast() else {
            return
        }
        
        let galaxyOne = allGalaxies[firstIndex]
        let galaxyTwo = allGalaxies[secondIndex]
        
        var resultGalaxies: [GalaxyModel] = []
        
        for (index, galaxy) in allGalaxies.enumerated() {
            if !([firstIndex, secondIndex].contains(index)) {
                resultGalaxies.append(galaxy)
            }
        }
        var newGalaxy: GalaxyModel
        
        if galaxyOne.mass > galaxyTwo.mass {
            newGalaxy = GalaxyModel(type: galaxyOne.type)
            newGalaxy.age = galaxyOne.age
        } else {
            newGalaxy = GalaxyModel(type: galaxyTwo.type)
            newGalaxy.age = galaxyTwo.age
        }

        newGalaxy.name = universe.nameGenerator.generate()
        
        guard let systemsOne = galaxyOne.planetarySystems, let systemsTwo = galaxyTwo.planetarySystems else {
            return
        }
        
        let allSystems = (systemsOne + systemsTwo).shuffled()
        newGalaxy.planetarySystems = Array(allSystems.prefix(Int(Double(allSystems.count) * 0.9)))

        resultGalaxies.insert(newGalaxy, at: 0)
        
        universe.galaxies = resultGalaxies
            
//        guard var allGalaxies = universe.galaxies as? [GalaxyModel] else {
//            return
//        }
//
//        let oldGalaxies = allGalaxies.filter { galaxy -> Bool in
//            galaxy.age > 3
//        }
//
//        guard oldGalaxies.count > 1 else { return }
//
//        var shuffledOldGalaxies = oldGalaxies.shuffled()
//
//        guard let galaxyOne = shuffledOldGalaxies.popLast(), let galaxyTwo = shuffledOldGalaxies.popLast() else {
//            return
//        }
//        allGalaxies = allGalaxies.filter({ galaxy in
//            return galaxy !== galaxyOne || galaxy !== galaxyTwo
//        })
//
//        var newGalaxy: GalaxyModel
//
//        if galaxyOne.mass > galaxyTwo.mass {
//            newGalaxy = GalaxyModel(type: galaxyOne.type)
//            newGalaxy.age = galaxyOne.age
//        } else {
//            newGalaxy = GalaxyModel(type: galaxyTwo.type)
//            newGalaxy.age = galaxyTwo.age
//        }
//
//        newGalaxy.name = universe.nameGenerator.generate()
//
//        guard let systemsOne = galaxyOne.planetarySystems, let systemsTwo = galaxyTwo.planetarySystems else {
//            return
//        }
//        let allSystems = (systemsOne + systemsTwo).shuffled()
//        newGalaxy.planetarySystems = Array(allSystems.prefix(Int(Double(allSystems.count) * 0.9)))
//
//        allGalaxies.insert(newGalaxy, at: 0)
//
//        universe.galaxies = allGalaxies
    }
}
