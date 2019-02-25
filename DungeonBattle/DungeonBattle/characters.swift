//
//  characters.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

var heroNameDict = [String: Any]()

class Hero {
    var name: String
    var life: Int
    var maxLife: Int
    var weapon: Weapon
    
    init(name: String, life: Int, weapon: Weapon){
        self.name = name
        self.life = life
        self.maxLife = life
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

class Warrior: Hero, CustomStringConvertible {
    // medium skills
    init(name: String){
        super.init(name: name, life: 100, weapon: Weapon(type: .Sword, effect: -10))
    }
    public var description: String{
        return "Guerrier"
    }
}

class Wizard: Hero, CustomStringConvertible {
    // healing only, not himself
    init(name: String){
        super.init(name: name, life: 130, weapon: Weapon(type: .Stick, effect: 5))
    }
    public var description: String{
        return "Magicien"
    }
}

class Colossus: Hero, CustomStringConvertible {
    // powerful, less damages, only fists
    init(name: String){
        super.init(name: name, life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
    public var description: String{
        return "Collosse"
    }
}

class Dwarf: Hero, CustomStringConvertible {
    // big axe, power damage, low life
    init(name: String){
        super.init(name: name, life: 50, weapon: Weapon(type: .Axe, effect: -40))
    }
    public var description: String{
        return "Nain"
    }
}


/* let myWarrior = Warrior()
print(myWarrior) => fait implicitiment reference à myWarriior.description
*/
