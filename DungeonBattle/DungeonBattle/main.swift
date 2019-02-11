//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//


class Game {
    var player1: Player!
    var player2: Player!
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
        player1 = createPlayer()
        player1.createTeam()
        print("\nC'est au joueur 2.")
        player2 = createPlayer()
        player2.createTeam()
    }
    
    func chooseHero(player: Player, pickerName: String) -> Hero {
        /*print ("""
            Veuillez choisir un personnage (tapez 1, 2 ou 3)
            1: \(player.team[0].name) - \(player.team[0].life)
            2: \(player.team[1].name) - \(player.team[1].life)
            3: \(player.team[2].name) - \(player.team[2].life)
            """)*/
        print("----------------------------------")
        print("\(pickerName)")
        print("Veuillez choisir un personnage (tapez 1, 2 ou 3)")
        for i in 0...player.team.count-1 {
            print("\(i+1): \(player.team[i]) ==> \(player.team[i].name) - PV = \(player.team[i].life) - Dégâts/soin \(player.team[i].weapon.effect)")
        }
        print("----------------------------------")
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
    
    func displayTeam(player: Player){
        for hero in player.team{
            print("\(hero.name) - \(hero.life)")
        }
    }
    
    /*func fight(){
        var lifePoint : Int // while ?
        lifePoint = chooseHero(player: Player).weapon.effect - chooseHero(player: Player).life // opération correct ?, pb syntaxe
        if chooseHero(player: Player) === Wizard{
            chooseHero(player: Player).wizard.weapon.effect + chooseHero(player: Player).life
        }
        
    
    }*/
    
    func fight(attacker: Player) {
        let opponent = getOpponent(player: attacker)
        let attackerHero = chooseHero(player: attacker, pickerName: attacker.name)
        let opponentHero = chooseHero(player: opponent, pickerName: attacker.name)
        
        opponentHero.life += attackerHero.weapon.effect
    }
    
}


let game = Game(playerTurn: 1)
game.startGame()
/*
while !game.finished {
    game.roll()
}
print("jeu terminé")
game.printStat()*/

//game.displayTeam(player: game.player2)
//game.fight(attacker: game.player1)
//game.displayTeam(player: game.player2)


/*creer le combat au tour par tour
 choisir un perso de l'équipe, puis choisir un adversaire (eneleve point de vie en fonction de l'arme)
 si mort -> inutilisable
 changement tour
 idem tour 1
 si reste personne ou mage solo fin du jeu (
 */

/*if player1.readline()===player2.readline(){
print ("Ce nom est déjà pris")
 } return nil
*/

// nom unique ne marche pas hors du player !
