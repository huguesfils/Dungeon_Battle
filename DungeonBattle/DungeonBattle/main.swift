//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

class Game {
    var player1: Player?
    var player2: Player?
    var playerTurn: Int
    
    
    init(playerTurn: Int) {
        self.playerTurn = playerTurn
    }
    
    func createPlayer() -> Player{
        var name = ""
        while name.isEmpty {
            print ("Quel est votre nom ?")
            name = readLine()!
        }
        print("\nBienvenue \(name) !")
        return Player(name: name)
    }
    
    func startGame(){
        let player1 = createPlayer()
        player1.createTeam()
        print("\nC'est au joueur 2.")
        let player2 = createPlayer()
        player2.createTeam()
    }
    
    func fight()-> Hero{
        print ("""
            Veuillez choisir avec quel personnage vous voulez combatre ce tour ( tapez 1,2 ou 3)
            1: \(player1!.team[0])
            2: \(player1!.team[1])
            3: \(player1!.team[2])
            """)
        for _ in 0..<player1!.team.count{
            let fighter = readLine()
            switch fighter{
            case "1" :
                print ("Vous avez choisi \(player1!.team[0])")
            case "2":
                print("Vous avez choisi \(player1!.team[1])")
            case "3":
                print("Vous avez choisi \(player1!.team[2])")
            default:
                print("Je ne comprends pas")
                
            }
            return fighter
            
        }
        print ("""
            Veuillez choisir avec quel personnage vous voulez attaquer ce tour ( tapez 1,2 ou 3)
            1: \(player2!.team[0])
            2: \(player2!.team[1])
            3: \(player2!.team[2])
            """)
        for _ in 0..<player2!.team.count{
            let fighter = readLine()
            switch fighter{
            case "1" :
                print ("Vous avez choisi \(player2!.team[0])")
            case "2":
                print("Vous avez choisi \(player2!.team[1])")
            case "3":
                print("Vous avez choisi \(player2!.team[2])")
            default:
                print("Je ne comprends pas")
            }
            
            
        }
    }
}

let game = Game(playerTurn: 1)


/*creer le combat au tour par tour
 choisir un perso de l'équipe, puis choisir un adversaire (eneleve point de vie en fonction de l'arme)
 si mort -> inutilisable
 changement tour
 idem tour 1
 si reste personne ou mage solo fin du jeu (
 */


