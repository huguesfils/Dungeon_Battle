//
//  Player.swift
//  DungeonBattle
//
//  Created by Hugues Fils Caparos on 24/12/2018.
//  Copyright © 2018 Hugues Fils. All rights reserved.
//

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
        }
        return name
    }
    
    func createTeam() {
        for _ in 1...3{
            let hero = createHero()
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
        print("\nVeuillez choisir un personnages parmi la liste suivante:")
        print("""
            1. Guerrier (PV = 100, Epée = 10 dégâts)
            2. Mage (PV = 70, Baton = 5 soins)
            3. Colosse (PV = 150, Poings = 20 dégâts)
            4. Nain (PV = 50, Hache = 40 dégâts)
            """) // ajouter les infos des persos
        
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
                        if teamContainsWizard(){
                            print("\nUn seul Mage par équipe.")
                            isHeroCreated = false
                            print("\nVeuillez choisir un personnages parmi la liste suivante:")
                            print("""
                            1. Guerrier (PV = 100, Epée = 10 dégâts)
                            2. Mage (PV = 70, Baton = 5 soin)
                            3. Colosse (PV = 150, Poings = 20 dégâts)
                            4. Nain (PV = 50, Hache = 40 dégâts)
                            """)
                        }else{
                            let wizardName = createHeroName()
                            hero = Wizard(name: wizardName)
                            isHeroCreated = true
                        }
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
