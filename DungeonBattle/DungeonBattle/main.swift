//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 23/11/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

// creation du fichier xcode

class Game {
    var player1: String
    var player2: String
    var playerTurn: Int
    
    init(player1: String, player2: String, playerTurn: Int) {
        self.player1 = player1
        self.player2 = player2
        self.playerTurn = playerTurn
    }
}

class Player {
    var name: String
    var team = [String]()
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
}

class Wizard: Hero {
    
}

class Warrior: Hero {
    
}

class Colossus: Hero {
    
}

class Dwarf: Hero {
    
}
