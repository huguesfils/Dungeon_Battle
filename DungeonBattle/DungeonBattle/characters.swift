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
    
    func genWeaponEffect() -> Int{
        if weapon.effect < 0 {
            return Int.random(in: weapon.effect - 10...weapon.effect - 5)
        }
        return Int.random(in: weapon.effect + 5...weapon.effect + 10)
    }
    public var description: String{
        return ""
    }
    public var info: String{
        return "\(description) (PV = \(life), \(weapon.type.rawValue) = \(weapon.effect))"
    }
}

enum WeaponType: String {
    case Sword = "Epée"
    case Stick = "Bâton"
    case Axe = "Hache"
    case Fists = "Poings"
    case Bow = "Arc"
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
    override public var description: String{
        return "Guerrier 🗡"
    }
}

class Wizard: Hero, CustomStringConvertible {
    // healing only, not himself
    init(name: String){
        super.init(name: name, life: 130, weapon: Weapon(type: .Stick, effect: 5))
    }
    override public var description: String{
        return "Magicien 🔮"
    }
}

class Colossus: Hero, CustomStringConvertible {
    // powerful, less damages, only fists
    init(name: String){
        super.init(name: name, life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
    override public var description: String{
        return "Collosse 💪"
    }
}

class Dwarf: Hero, CustomStringConvertible {
    // big axe, power damage, low life
    init(name: String){
        super.init(name: name, life: 70, weapon: Weapon(type: .Axe, effect: -40))
    }
    override public var description: String{
        return "Nain ⛏"
    }
}

class Archer: Hero, CustomStringConvertible {
    // medium skills
    init(name: String){
        super.init(name: name, life: 50, weapon: Weapon(type: .Bow, effect: -50))
    }
    override public var description: String{
        return "Archer 🏹"
    }
}


/* let myWarrior = Warrior()
print(myWarrior) => fait implicitiment reference à myWarriior.description
*/
