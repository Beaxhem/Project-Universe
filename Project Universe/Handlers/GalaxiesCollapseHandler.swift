//
//  GalaxiesCollapseHandler.swift
//  Project Universe
//
//  Created by Ilya Senchukov on 27.01.2021.
//

func arrayOfCommonElements <T, U> (lhs: T, rhs: U) -> [T.Element] where T: Sequence, U: Sequence, T.Element: Equatable, T.Element == U.Element {
    var returnArray:[T.Element] = []
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                returnArray.append(lhsItem)
            }
        }
    }
    return returnArray
}

class GalaxiesCollapseHandler: Handler {
    var timeInterval: Int = 30
    
    func handle(obj: SpaceObject) {
        guard let universe = obj as? UniverseModel else {
            return
        }
        
        guard var allGalaxies = universe.galaxies as? [GalaxyModel] else {
            return
        }
        
        let oldGalaxies = allGalaxies.filter { galaxy -> Bool in
            galaxy.age > 3*60
        }
        
        var shuffledOldGalaxies = oldGalaxies.shuffled()
        
        guard let galaxyOne = shuffledOldGalaxies.popLast(), let galaxyTwo = shuffledOldGalaxies.popLast() else {
            return
        }
        
        allGalaxies = allGalaxies.filter({ galaxy -> Bool in
            return galaxy != galaxyOne || galaxy != galaxyTwo
        })
        
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
        
        allGalaxies.insert(newGalaxy, at: 0)
        
        universe.galaxies = allGalaxies
        
//        guard var allGalaxies = universe.galaxies as? [GalaxyModel] else {
//            return
//        }
//
//        var galaxies = allGalaxies.filter { (galaxy) -> Bool in
//            galaxy.age > 3*60
//        }
//        guard galaxies.count >= 2 else {
//            return
//        }
//        var shuffledGalaxies = galaxies.shuffled()
//
//        guard let galaxyOne = shuffledGalaxies.popLast(), let galaxyTwo = shuffledGalaxies.popLast() else {
//            return
//        }
//
//        galaxies = arrayOfCommonElements(lhs: galaxies, rhs: shuffledGalaxies)
//
//        var newGalaxy: GalaxyModel
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
//        let systemsOne = galaxyOne.planetarySystems ?? []
//        let systemsTwo = galaxyTwo.planetarySystems ?? []
//        let allSystems = systemsOne + systemsTwo
//        newGalaxy.planetarySystems = Array(allSystems.prefix(Int(Double(allSystems.count) * 0.9)))
//        allGalaxies = arrayOfCommonElements(lhs: allGalaxies, rhs: galaxies)
//        allGalaxies.insert(newGalaxy, at: 0)
//
//        universe.galaxies = allGalaxies
    }
}
