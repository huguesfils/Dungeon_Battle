//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 23/11/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

class Game {
    var player1: Player
    var player2: Player
    var playerTurn: Int
    
    init(player1: Player, player2: Player, playerTurn: Int) {
        self.player1 = player1
        self.player2 = player2
        self.playerTurn = playerTurn
    }
    
    func nameDeclaration(){
        print ("Quel est votre nom ?")
        if let player1 = readLine(){
            print("Bonjour \(player1)")
        }
        if let player2 = readLine(){
            print("Bonjour \(player2)")
        }
    }
    
    
    
    
    
}

class Player {
    var name: String
    var team = [Hero]()
    init (name: String){
        self.name = name
    }
    
    func addHeroTeam(hero: Hero) {
        if (team.count < 3) {
            team.append(hero)
        }
    }
}

class Hero {
    var name: String
    var life: Int
    var weapon: Weapon
    
    init(name: String, life: Int, weapon: Weapon){
        self.name = name
        self.life = life
        self.weapon = weapon
    }
    
    func nameDeclaration(){
        print ("Quel est votre nom ?")
        if let characterName = readLine(){
            print("Bonjour \(characterName)")
        }
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
    init(){
            super.init(name: "", life: 100, weapon: .init(type: .Sword, effect: -10))
    }
}

class Wizard: Hero {
    // healing only, not himself
}

class Colossus: Hero {
    // powerful, less damages, only fists
}

class Dwarf: Hero {
    // big axe, power damage, low life
}
