//
//  main.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

import Foundation

class Game {
    var player1: Player!
    var player2: Player!
    var currentPlayer: Player!
    var rollCount = 0
    
    func createPlayer() -> Player {
        var name = ""
        while name.isEmpty {
            print ("\nQuel est votre nom ?")
            name = readLine()!
        }
        print("\nBienvenue \(name) !")
        return Player(name: name)
    }
    
    func startGame(){
        // Introduction, game rules
        print ("""
                Bienvenue dans Dungeon Battle 🏰
                \nLe but du jeu est d'éliminer l'équipe adverse. Vous devez constituez une équipe de 3 personnage parmi les 5 disponibles.
                \nLe magicien ne peux que soigner ses alliés, s'il est seul survivant de votre équipe vous perdez la partie.
                Choisissez vos héros avec soin !
                \n⚔️ Que la partie commence ! ⚔️\n
                """)
        sleep(1)
        player1 = createPlayer()
        sleep(1)
        player1.createTeam()
        sleep(1)
        print("\nC'est au joueur 2.")
        player2 = createPlayer()
        sleep(1)
        player2.createTeam()
        self.currentPlayer = player1
    }
    
    func chooseHero(player: Player, pickerName: String) -> Hero {
        displayChooseHero(player: player, pickerName: pickerName)
        var index = -1
        repeat {
            if let choice = readLine(){ // on vérifie que l'utilisateur a bien saisi une String
                if let choiceInt = Int(choice){ // on vérifie que ce qui est saisi est bien un entier (on essaye de le convertir, si ça passe OK)
                    switch choiceInt {
                    case 1, 2, 3 : // si l'utilisateur a saisi 1, 2 ou 3
                        index = choiceInt-1 // on met à jour le bon index
                        print ("Vous avez choisi \(player.team[index].name)")
                        if player.team[index].life <= 0 {
                            print ("Ce personnage est mort.")
                            displayChooseHero(player: player, pickerName: pickerName)
                            index = -1
                        }
                        
                    default: // dans les autres cas index n'est pas touché et vaut donc -1
                        print("Je ne comprends pas")
                    }
                }
            }
            
        } while index < 0 //on recommence tant que index n'a pas une valeur correcte (car un tableau commence toujours à l'index 0)
        
        return player.team[index]
    }
    
    func displayChooseHero(player: Player, pickerName: String){
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
    
    func fight(attacker: Player) {
        let attackerHero = chooseHero(player: attacker, pickerName: attacker.name)
        bonus(hero: attackerHero)
        if attackerHero is Wizard {
            var healedHero:Hero!
            repeat {
                healedHero = chooseHero(player: attacker, pickerName: attacker.name)
                if attackerHero.name == healedHero.name {
                    print("\(attackerHero.name) ne peut pas s'auto-soigner !")
                }
            } while attackerHero.name == healedHero.name
            healedHero.life += attackerHero.weapon.effect
            if healedHero.life > healedHero.maxLife {
                healedHero.life = healedHero.maxLife
            }
        } else {
            let opponent = getOpponent(player: attacker)
            let opponentHero = chooseHero(player: opponent, pickerName: attacker.name)
            opponentHero.life += attackerHero.weapon.effect
        }
    }
    
    func finished(player: Player) -> Bool {
        var wizardCount = 0
        var heroAlive = 0
        for hero in player.team{
            if hero.life > 0 {
                heroAlive += 1
                if hero is Wizard {
                    wizardCount += 1
                }
            }
        }
        if heroAlive > 0 && heroAlive != wizardCount{
            return false
        }
        return true
    }
    
    func roll(){
        sleep(1)
        print("\nC'est au tour de \(currentPlayer.name).")
        fight(attacker: currentPlayer)
        currentPlayer = getOpponent(player: currentPlayer)
        rollCount += 1
    }
    
    func bonus(hero: Hero){
        let randomNumber = Int.random(in: 0...2)
        if rollCount % 2 == randomNumber {
            print("Un coffre contenant une nouvelle arme est apparût, \(hero.name) s'en équipe !")
            hero.weapon.effect = hero.genWeaponEffect()
            print ("Le nouvel effet de son arme est de \(hero.weapon.effect).")
        }
        sleep(1)
    }
}
// MARK: - Game execution
let game = Game()
game.startGame()
while !game.finished(player: game.player1) && !game.finished(player: game.player2){
    game.roll()
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
