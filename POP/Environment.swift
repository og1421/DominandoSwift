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
    case forest,
         savanna,
         montain,
         desert
}

enum Dietary {
    case carnivore,
         herbivore,
         omnivere

}

protocol Organism {
    var name: String { get }
    var habitat: Habitat { get }
}

class Animal: Organism, Movable{
    let name: String
    let habitat: Habitat
    let dietary: Dietary
    var commonFood: [String]
    
    init(name: String, habitat: Habitat, dietary: Dietary, commonFood: [String]) {
        self.name = name
        self.habitat = habitat
        self.dietary = dietary
        self.commonFood = commonFood
    }
    
    func move() {
        print("\(name) is moving")
    }
    
    func running() {
        print("\(name) is running")
    }
    
    func eat(_ organism: String) {
        print("\(name) is eating \(organism)")
    }
    
    func drinkWater() {
        print("\(name) is drinking water")
    }
}

class Plant: Organism, Photosyntesis {
    let name: String
    let habitat: Habitat
    let fruit: Bool
    let berry: String?
    
    init(name: String, habitat: Habitat, fruit: Bool, berry: String? = nil) {
        self.name = name
        self.habitat = habitat
        self.fruit = fruit
        self.berry = fruit ?  berry : nil
    }
    
    func performPhotosyntesis() {
        print("\(name) is performing photosintesis")
    }
}

let lion = Animal(name: "Lion", habitat: .savanna, dietary: .carnivore, commonFood: ["Giraffe", "Deer", "Zebra"])
let wolf = Animal(name: "Wolf", habitat: .montain, dietary: .carnivore, commonFood: ["Rabits", "Montain Deer", "Squirrel"])
let squirrel = Animal(name: "Squirrel", habitat: .montain, dietary: .herbivore, commonFood: ["Pine", "Juglans"])
let deer = Animal(name: "Montain Deer", habitat: .montain, dietary: .herbivore, commonFood: ["Browse"])

let tree = Plant(name: "Orange Tree", habitat: .forest, fruit: true, berry: "Orange")
let pineTree = Plant(name: "Pine Tree", habitat: .montain, fruit: true, berry: "Pine")
let cactus = Plant(name: "Cactus", habitat: .desert, fruit: false)


let organisms: [Organism] = [lion, wolf, tree, cactus, pineTree, squirrel, deer]

for organism in organisms {
    if let animal  = organism as? Animal {
        animal.move()
        
        for food in organisms {
            if food.habitat == animal.habitat {
                
                if animal.dietary == .carnivore, food is Animal, food.name != animal.name, animal.commonFood.contains(food.name){
                    animal.eat(food.name)
                    
                } else if animal.dietary == .omnivere, food.name != animal.name, animal.commonFood.contains(food.name){
                    animal.eat(food.name)
                    
                } else if animal.dietary == .herbivore {
                    if let animalFood = food as? Plant {
                        if animalFood.fruit, animal.commonFood.contains(animalFood.berry ?? ""){
                            animal.eat(animalFood.berry ?? "")
                            
                        } else if animal.commonFood.contains(animalFood.name){
                            animal.eat(animalFood.name)
                        }
                    }
                } else {
                    animal.move()
                }
                
            } else {
                animal.move()
            }
        }
        
    } else if let plant = organism as? Plant {
        plant.performPhotosyntesis()
    }
}


