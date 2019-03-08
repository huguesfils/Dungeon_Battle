//
//  Player.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

let HERO_PER_TEAM = 3 // We create a constant which contains the maximum characters in a player's team.

class Player { // A player need a name and an array (a team).
    var name: String
    var team = [Hero]() // the team is made of characters (Hero).
    init (name: String){
        self.name = name
    }
    
    func isNameUnique(name: String) -> Bool{ // To check if the name is unique, we have to verify all the names in the array
        if heroNameDict[name] != nil{
            return false
        }
        return true
    }
    
    func createHeroName() -> String { // When the player choose a hero, he has to give it a name
        var name = ""
        while name.isEmpty {
            print ("Quel est son nom ?")
            name = readLine()! // The player write the name
            if !isNameUnique(name: name) { // If the name is already taken, we ask again until it's unique
                print ("Ce nom est déjà pris !")
                name = ""
            }
        }
        heroNameDict[name] = name // We put all the names in an array
        return name
    }
    /*
     func teamContainsWizard() -> Bool{
     for hero in team{
     if hero is Wizard{
     return true
     }
     }
     return false
     }*/
    
    func createHero() -> Hero{
        let warrior = Warrior(name: "A")
        let wizard = Wizard(name: "B")
        let colossus = Colossus(name: "C")
        let dwarf = Dwarf(name: "D")
        let archer = Archer(name: "E")
        print("\nVeuillez choisir un personnages parmi la liste suivante:\n")
        print("""
            1. \(warrior.info)
            2. \(wizard.info)
            3. \(colossus.info)
            4. \(dwarf.info)
            5. \(archer.info)
            """)
        
        var hero: Hero! // Hero is an optional, here we are sure that Hero contains a value
        var isHeroCreated = false 
        
        while !isHeroCreated {
            if let line = readLine(){
                if let choice = Int(line) {
                    switch choice {
                    case 1:
                        let warriorName = createHeroName()
                        hero = Warrior(name: warriorName)
                        isHeroCreated = true
                    case 2:
                        let wizardName = createHeroName()
                        hero = Wizard(name: wizardName)
                        isHeroCreated = true
                    case 3:
                        let colossusName = createHeroName()
                        hero = Colossus(name: colossusName)
                        isHeroCreated = true
                    case 4:
                        let dwarfName = createHeroName()
                        hero = Dwarf(name: dwarfName)
                        isHeroCreated = true
                    case 5:
                        let archerName = createHeroName()
                        hero = Archer(name: archerName)
                        isHeroCreated = true
                    default:
                        print("Veuillez taper un chiffre compris entre 1 et 5")
                    }
                }
                else {
                    print("Veuillez taper un chiffre compris entre 1 et 4")
                    isHeroCreated = false
                }
            }
        }
        return hero
    }
    
    func createTeam() {
        var wizardCount = 0
        for _ in 1...HERO_PER_TEAM { // the loop goes from 1 to 3 (HERO_PER_TEAM is a maximum)
            var hero = createHero() // we ask the player to choose a character
            // While the chosen hero is a wizard and we've reach le maximum number of wizard in a team,
            while hero is Wizard && wizardCount == HERO_PER_TEAM - 1{
                print("Vous ne pouvez pas avoir plus de \(HERO_PER_TEAM - 1) mages !")
                hero = createHero() // then we ask the player to choose a hero again
            }
            // when everything is good, we save the number of wizard in the team
            if hero is Wizard {
                wizardCount += 1
            }
            //at the end, we put the hero in the array [team]
            team.append(hero)
        }
    }
}
