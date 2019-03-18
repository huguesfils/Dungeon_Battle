//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

import Foundation

class Game {
    var player1: Player! // We need 2 players, so we create them and we say that the player is a Player (class), it's an optional so we unwrap it.
    var player2: Player!
    var currentPlayer: Player!
    var rollCount = 0
    
    func createPlayer() -> Player { //We need to create the player
        var name = "" // the default name is nothing, it's empty
        while name.isEmpty {
            print ("\nQuel est votre nom ?")
            name = readLine()!// the user enter his name
        }
        print("\nBienvenue \(name) !")
        return Player(name: name) // the function create the player with the name writen by the user
    }
    
    func startGame(){ // the beginning of the need a proper exection
        // Introduction, game rules
        print ("""
                Bienvenue dans Dungeon Battle 🏰
                \nLe but du jeu est d'éliminer l'équipe adverse. Vous devez constituez une équipe de 3 personnage parmi les 5
                disponibles.
                \nLe magicien ne peux que soigner ses alliés, s'il est seul survivant de votre équipe vous perdez la partie.
                Choisissez vos héros avec soin !
                \n⚔️ Que la partie commence ! ⚔️\n
                """)
        sleep(1)// We ask the game to reduce the display speed (1sec)
        player1 = createPlayer() // the player 1 is created by the function createPlayer()
        sleep(1)
        player1.createTeam() // Same for his team (func in Player.swift)
        sleep(1)
        print("\nC'est au joueur 2.")
        player2 = createPlayer()
        sleep(1)
        player2.createTeam()
        self.currentPlayer = player1
    }
    
    func displayChooseHero(player: Player, pickerName: String){ // We have to show to the user his team
        print("----------------------------------")
        print("\(pickerName) :")
        print("Veuillez choisir un personnage 👇 (tapez 1, 2 ou 3)")
        
        for i in 0...player.team.count-1 {
            
            if player.team[i].life > 0{
                print("\(i+1): \(player.team[i].name) ==> \(player.team[i].info)")
            }
        }
        print("----------------------------------")
    }
    
    func chooseHero(player: Player, pickerName: String) -> Hero { // now the user have to choose a hero for fight or heal
        displayChooseHero(player: player, pickerName: pickerName)
        var index = -1
        repeat {
            if let choice = readLine(){ // We check that the user use the keyboard
                if let choiceInt = Int(choice){ // we check that the key entered is an Int
                    switch choiceInt {
                    case 1, 2, 3 : // if the user enter 1, 2 or 3
                        index = choiceInt-1 // we update the choice counter
                        print ("Vous avez choisi \(player.team[index].name)")
                        if player.team[index].life <= 0 { //
                            print ("Ce personnage est mort.")
                            displayChooseHero(player: player, pickerName: pickerName)
                            index = -1
                        }
                        
                    default: // In the other cases the index is not modified, so it is still -1
                        print("Je ne comprends pas")
                    }
                }
            }
            
        } while index < 0 // We do it again until the index does not have a correct value (an array always starts at 0)
        
        return player.team[index]
    }
    
    func getOpponent(player: Player) -> Player {// how to get the opponent
        if player === player1! { // if the player is player1 we return player 2
            return player2!
        }
        else {
            return player1! // if not, we do the opposit
        }
    }
    
    func bonus(hero: Hero){// we need to generate a random new effect for weapons
        let randomNumber = Int.random(in: 0...2) // our random number is between 0 and 2, even or odd
        if rollCount % 2 == randomNumber { // if the randomNumber is equal to the rest of the division by 2, we use the .genWeponEffect
            print("Un coffre contenant une nouvelle arme est apparût, \(hero.name) s'en équipe !")
            hero.weapon.effect = hero.genWeaponEffect()
            print ("Le nouvel effet de son arme est de \(hero.weapon.effect).")
        }
        sleep(1)
    }
    
    func fight(attacker: Player) {
        let attackerHero = chooseHero(player: attacker, pickerName: attacker.name)
        bonus(hero: attackerHero)
        if attackerHero is Wizard { // the wizard can only heal
            var healedHero:Hero!
            repeat {
                healedHero = chooseHero(player: attacker, pickerName: attacker.name) // we need to avoid self heal
                if attackerHero.name == healedHero.name {
                    print("\(attackerHero.name) ne peut pas s'auto-soigner !")
                }
            } while attackerHero.name == healedHero.name // avoid heal beyond the maximum life points of a hero
            healedHero.life += attackerHero.weapon.effect
            if healedHero.life > healedHero.maxLife {
                healedHero.life = healedHero.maxLife
            }
        } else { //
            let opponent = getOpponent(player: attacker) // the opponent is created by getOpponent()
            let opponentHero = chooseHero(player: opponent, pickerName: attacker.name)
            opponentHero.life += attackerHero.weapon.effect
        }
    }
    
    func roll(){ // need a function roll to change the current player
        sleep(1)
        print("\nC'est au tour de \(currentPlayer.name).")
        fight(attacker: currentPlayer)
        currentPlayer = getOpponent(player: currentPlayer)
        rollCount += 1
    }
    
    func finished(player: Player) -> Bool {
        var wizardCount = 0
        var heroAlive = 0
        for hero in player.team{ // we check every hero in the team
            if hero.life > 0 { // If their life is over 0
                heroAlive += 1 // we add 1 to the heroAlive counter
                if hero is Wizard { // same if it is a wizard
                    wizardCount += 1
                }
            }
        }
        if heroAlive > 0 && heroAlive != wizardCount{ // If is their a hero still alive and if the number of hero is defferent of the number of wizard
            return false // then the game is not finished
        }
        return true // if not the game is finished
    }
}


// Main loop

// MARK: - Game execution
let game = Game()
game.startGame()
while !game.finished(player: game.player1) && !game.finished(player: game.player2){ // while the game is not finished
    game.roll() // function roll() continues to work
}
sleep(1)
print("\n⭐️Fin de la partie !⭐️")
if game.finished(player: game.player1){
    print("\nFélicitation \(game.player2.name) !")
}else{
    print("\nFélicitation \(game.player1.name) !")
}
if game.rollCount <= 5{
    print ("Wow, ce fût rapide ! Vous avez terrassé votre adversaire en \(game.rollCount) tours.")
}else{
    print ("Vous avez terrassé votre adversaire en \(game.rollCount) tours.")
}
