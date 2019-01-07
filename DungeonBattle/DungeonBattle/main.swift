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
    
    func chooseHero(player: Player) -> Hero {
        print ("""
            Veuillez choisir un personnage (tapez 1, 2 ou 3)
            1: \(player.team[0])
            2: \(player.team[1])
            3: \(player.team[2])
            """)
        var index = -1
        
        repeat {
            if let choice = readLine(){ // on vérifie que l'utilisateur a bien saisi une String
                if let choiceInt = Int(choice){ // on vérifie que ce qui est saisi est bien un entier (on essaye de le convertir, si ça passe OK)
                    switch choiceInt {
                    case 1, 2, 3 : // si l'utilisateur a saisi 1, 2 ou 3
                        index = choiceInt-1 // on met à jour le bon index
                        print ("Vous avez choisi \(player.team[index])")
                        
                    default: // dans les autres cas index n'est pas touché et vaut donc -1
                        print("Je ne comprends pas")
                    }
                }
            }
        } while index < 0 //on recommence tant que index n'a pas une valeur correcte (car un tableau commence toujours à l'index 0)
        
        return player.team[index]
    }
    
    func getOpponent(player: Player) -> Player {
        if player === player1! {
            return player2!
        }
        else {
            return player1!
        }
    }
    
    
}

/*func chooseHero() -> Hero{
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
 }*/


let game = Game(playerTurn: 1)


/*creer le combat au tour par tour
 choisir un perso de l'équipe, puis choisir un adversaire (eneleve point de vie en fonction de l'arme)
 si mort -> inutilisable
 changement tour
 idem tour 1
 si reste personne ou mage solo fin du jeu (
 */


