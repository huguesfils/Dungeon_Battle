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
    var currentPlayer: Player!
    var rollCount = 0
    
    func createPlayer() -> Player {
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
                        print ("Vous avez choisi \(player.team[index])")
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
        print("\(pickerName)")
        print("Veuillez choisir un personnage (tapez 1, 2 ou 3)")
        
        for i in 0...player.team.count-1 {
            
            if player.team[i].life > 0{
                print("\(i+1): \(player.team[i]) ==> \(player.team[i].name) - PV = \(player.team[i].life) - Effet \(player.team[i].weapon.effect)")
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
            if hero.life >= 0 {
                heroAlive += 1
                if hero is Wizard {
                    wizardCount += 1
                }
            }
        }
        print ("heroAlive = \(heroAlive) - wizardCount = \(wizardCount)")
        if heroAlive >= 0 && heroAlive != wizardCount{
            return false
        }
        return true
    }
    
    func roll(){
        print("C'est au tour de \(currentPlayer.name)")
        fight(attacker: currentPlayer)
        currentPlayer = getOpponent(player: currentPlayer)
        rollCount += 1
    }
    
    
}




let game = Game()
game.startGame()
while !game.finished(player: game.player1) && !game.finished(player: game.player2){
    game.roll()
}
print("jeu terminé")
if game.finished(player: game.player1){
    print("Félicitaion \(game.player2.name) !")
}else{
    print("Félicitaion \(game.player1.name) !")
}
print ("La partie s'est terminée en \(game.rollCount) tours.")
print("\n\n")
game.displayChooseHero(player: game.player1, pickerName: game.player1.name)
game.displayChooseHero(player: game.player2, pickerName: game.player2.name)



/*func fight3(attacker: Player) {
 var opponentHero: Hero!
 let opponent = getOpponent(player: attacker)
 let attackerHero = chooseHero(player: attacker, pickerName: attacker.name)
 if attackerHero is Wizard {
 opponentHero = chooseHero(player: attacker, pickerName: attacker.name)
 }else{
 opponentHero = chooseHero(player: opponent, pickerName: attacker.name)
 }
 opponentHero.life += attackerHero.weapon.effect
 }
 
 func fight2(attacker: Player) {
 var opponent = getOpponent(player: attacker)
 let attackerHero = chooseHero(player: attacker, pickerName: attacker.name)
 if attackerHero is Wizard {
 opponent = attacker
 }
 let opponentHero = chooseHero(player: opponent, pickerName: attacker.name)
 opponentHero.life += attackerHero.weapon.effect
 }*/


//voir commande random pour gerer le hazard Int.random => Apparition du coffre au contenant une nouvelle arme 
