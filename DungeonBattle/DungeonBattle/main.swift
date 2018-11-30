//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 23/11/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

class Game {
    var player1: String
    var player2: String
    var playerTurn: Int
    
    init(player1: String, player2: String, playerTurn: Int) {
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
    var team = [String: Int]()
    init (name: String){
        self.name = name
    }
}

class Hero {
    var name: String
    var life: Int
    var weapon: String
    
    init(name: String, life: Int, weapon: String){
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

class Warrior: Hero {
    // medium skills
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
