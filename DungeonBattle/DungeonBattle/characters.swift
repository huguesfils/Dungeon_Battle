//
//  characters.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//
class Hero {
    var name: String
    var life: Int
    var weapon: Weapon
    
    init(name: String, life: Int, weapon: Weapon){
        self.name = name
        self.life = life
        self.weapon = weapon
    }
}

enum WeaponType {
    case Sword
    case Stick
    case Axe
    case Fists
}

class Weapon{
    var type: WeaponType
    var effect: Int
    
    init(type: WeaponType, effect: Int){
        self.type = type
        self.effect = effect
    }
}

class Warrior: Hero {
    // medium skills
    init(name: String){
        super.init(name: name, life: 100, weapon: Weapon(type: .Sword, effect: -10))
    }
}

class Wizard: Hero {
    // healing only, not himself
    init(name: String){
        super.init(name: name, life: 70, weapon: Weapon(type: .Stick, effect: 5))
    }
}

class Colossus: Hero {
    // powerful, less damages, only fists
    init(name: String){
        super.init(name: name, life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
}

class Dwarf: Hero {
    // big axe, power damage, low life
    init(name: String){
        super.init(name: name, life: 50, weapon: Weapon(type: .Axe, effect: -40))
    }
}
