//
//  Player.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

let HERO_PER_TEAM = 3

class Player {
    var name: String
    var team = [Hero]()
    init (name: String){
        self.name = name
    }
    
    func createHeroName() -> String {
        var name = ""
        while name.isEmpty {
            print ("Quel est son nom ?")
            name = readLine()!
            if !isNameUnique(name: name) {
                  print ("Ce nom est déjà pris !")
                name = ""
            }
        }
        heroNameDict[name] = name
        return name
    }
    
    func isNameUnique(name: String) -> Bool{
        if heroNameDict[name] != nil{
            return false
        }
        return true
    }
    
    func createTeam() {
        var wizardCount = 0
        for _ in 1...HERO_PER_TEAM { // on va de 1 à 3
            var hero = createHero() // on de mande au joueur de choisir un personnage
            // Tant que le hero choisit est un mage et qu'on a atteint le maximum de mage par equipe
            while hero is Wizard && wizardCount == HERO_PER_TEAM - 1{
                print("Vous ne pouvez pas avoir plus de \(HERO_PER_TEAM - 1) mages !")
                hero = createHero() // alors on redemande de choisir un personnage
            }
            // une fois que tout est OK, on sauvegarde le nombre de mage dans l'équipe
            // ne pas oublier qu'on est dans une boucle, donc au prochain choix de hero on se servira de wizardCount
            if hero is Wizard {
                wizardCount += 1
            }
            //on ajoute le hero à la team
            team.append(hero)
          
        }
    }
    
    func teamContainsWizard() -> Bool{
        for hero in team{
            if hero is Wizard{
                return true
            }
        }
        return false
    }
    
    func createHero() -> Hero{
        let warrior = Warrior(name: "A")
        print("\nVeuillez choisir un personnages parmi la liste suivante:")
        print("""
            1. \(warrior.info)
            2. Mage (PV = 70, Baton = 5 soins)
            3. Colosse (PV = 150, Poings = 20 dégâts)
            4. Nain (PV = 50, Hache = 40 dégâts)
            """)
        
        var hero: Hero!
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
                        /*if teamContainsWizard(){
                            print("\nUn seul Mage par équipe.")
                            isHeroCreated = false
                            print("\nVeuillez choisir un personnages parmi la liste suivante:")
                            print("""
                            1. Guerrier (PV = 100, Epée = 10 dégâts)
                            2. Mage (PV = 70, Baton = 5 soin)
                            3. Colosse (PV = 150, Poings = 20 dégâts)
                            4. Nain (PV = 50, Hache = 40 dégâts)
                            """)
                        }else{*/
                            let wizardName = createHeroName()
                            hero = Wizard(name: wizardName)
                            isHeroCreated = true
                        //}
                    case 3:
                        let colossusName = createHeroName()
                        hero = Colossus(name: colossusName)
                        isHeroCreated = true
                    case 4:
                        let dwarfName = createHeroName()
                        hero = Dwarf(name: dwarfName)
                        isHeroCreated = true
                    default:
                        print("Veuillez taper un chiffre compris entre 1 et 4")
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
    
}
