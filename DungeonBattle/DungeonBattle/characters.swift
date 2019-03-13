//
//  characters.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

var heroNameDict = [String: Any]() // We need to put the name entered by player in a dictionnary to verify if the names are unique and it is provived an easily acces to any value.
// A Hero class with all properties a character needs
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
    
    func genWeaponEffect() -> Int{  // We need to generate a new weapon effect as request in the bonus chest
        if weapon.effect < 0 {    //  if a hero causes damages, the effect will be less than 0
            return Int.random(in: weapon.effect - 10...weapon.effect - 5)
        } // if not, the hero can heal so the effect will be superior than 0
        return Int.random(in: weapon.effect + 5...weapon.effect + 10)
    }
   
    public var description: String{ // We need a public description for calling a hero the way we want, whithout changing the name -> Warrior become "Guerrier", easy to translate.
        return ""
    }
    
    public var info: String{ // with .info we have all infos we need in one command
        return "\(description) (PV = \(life), \(weapon.type.rawValue) = \(weapon.effect))"
    }
}
// The enumeration contains all the weapon types we need, and we can add a value for translation.
enum WeaponType: String {
    case Sword = "Epée"
    case Stick = "Bâton"
    case Axe = "Hache"
    case Fists = "Poings"
    case Bow = "Arc"
}
// We create a weapon class, thank to this we can call .weapon anywere we want, and a weapon is an object that we can use everywhere in the program
class Weapon{
    var type: WeaponType
    var effect: Int // +/-
    
    init(type: WeaponType, effect: Int){
        self.type = type
        self.effect = effect
    }
}
 // each characters heritate the Hero class, each characters is a class, with their own properties and description
class Warrior: Hero { //
    init(name: String){
        super.init(name: name, life: 100, weapon: Weapon(type: .Sword, effect: -10))
    }
    override public var description: String{
        return "Guerrier 🗡"
    }
}

class Wizard: Hero {
    init(name: String){
        super.init(name: name, life: 130, weapon: Weapon(type: .Stick, effect: 5))
    }
    override public var description: String{
        return "Magicien 🔮"
    }
}

class Colossus: Hero {
    init(name: String){
        super.init(name: name, life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
    override public var description: String{
        return "Collosse 💪"
    }
}

class Dwarf: Hero {
    init(name: String){
        super.init(name: name, life: 70, weapon: Weapon(type: .Axe, effect: -40))
    }
    override public var description: String{
        return "Nain ⛏"
    }
}

class Archer: Hero {
    init(name: String){
        super.init(name: name, life: 50, weapon: Weapon(type: .Bow, effect: -50))
    }
    override public var description: String{
        return "Archer 🏹"
    }
}
