//
//  File.swift
//  
//
//  Created by Orlando Moraes Martins on 30/08/23.
//

import Foundation

protocol Movable {
    func move()
}


protocol Photosyntesis {
    func performPhotosyntesis()
}

enum Habitat {
    case forest
    case savanna
    case montain
    case desert
}

protocol Organism {
    var name: String { get }
    var habitat: Habitat { get }
}

class Animal: Organism, Movable{
    let name: String
    let habitat: Habitat
    
    init(name: String, habitat: Habitat) {
        self.name = name
        self.habitat = habitat
    }
    
    func move() {
        print("\(name) is moving")
    }
    
    func eat() {
        print("\(name) is eating")
    }
}

class Plant: Organism, Photosyntesis {
    let name: String
    let habitat: Habitat
    
    init(name: String, habitat: Habitat) {
        self.name = name
        self.habitat = habitat
    }
    
    func performPhotosyntesis() {
        print("\(name) is performing photosintesis")
    }
}

let lion = Animal(name: "Lion", habitat: .savanna)
let wolf = Animal(name: "Wolf", habitat: .montain)
let tree = Plant(name: "Tree", habitat: .forest)
let cactus = Plant(name: "Cactus", habitat: .desert)


let organisms: [Organism] = [lion, wolf, tree, cactus]

for organism in organisms {
    if let animal  = organism as? Animal {
        animal.move()
        animal.eat()
        
    } else if let plant = organism as? Plant {
        plant.performPhotosyntesis()
    }
}


