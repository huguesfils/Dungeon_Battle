class Game {
    var player1: Player?
    var player2: Player?
    var playerTurn: Int
    var team = [Hero]()
    
    init(playerTurn: Int) {
        self.playerTurn = playerTurn
    }
    
    func createPlayer() -> Player{
        var name = ""
        while name.isEmpty {
            print ("\nQuel est votre nom ?")
            name = readLine()!
            print("\nBienvenue \(name) !")
        }
        return Player(name: name)
    }
    
    func createHero() -> Hero{
        print("\nVeuillez choisir 3 personnages parmi la liste suivante")
        print("1. Guerrier (PV = 100, Epée = 10 dégâts \n2. Mage\n3. Colosse\n4. Nain") // ajouter les infos des persos
        
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
    
    func createHeroName() -> String {
        var name = ""
        while name.isEmpty {
            print ("Quel est son nom ?")
            name = readLine()!
        }
        return name
    }
    
    func createTeam() {
        for _ in 1...3 {
            let hero = createHero()
            team.append(hero)
        }
    }
}


class Player {
    var name: String
    init (name: String){
        self.name = name
    }
}

class Hero {
    var name: String
    var life: Int
    var weapon: Weapon
    
    init(name: String, life: Int, weapon: Weapon){
        self.name = name
        self.life = life
        self.weapon = weapon
    }
}

enum WeaponType {
    case Sword
    case Stick
    case Axe
    case Fists
}

class Weapon{
    var type: WeaponType
    var effect: Int
    
    init(type: WeaponType, effect: Int){
        self.type = type
        self.effect = effect
    }
}

class Warrior: Hero {
    // medium skills
    init(name: String){
        super.init(name: name, life: 100, weapon: Weapon(type: .Sword, effect: -10))
    }
}

class Wizard: Hero {
    // healing only, not himself
    init(name: String){
        super.init(name: name, life: 70, weapon: Weapon(type: .Stick, effect: 5))
    }
}

class Colossus: Hero {
    // powerful, less damages, only fists
    init(name: String){
        super.init(name: name, life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
}

class Dwarf: Hero {
    // big axe, power damage, low life
    init(name: String){
        super.init(name: name, life: 50, weapon: Weapon(type: .Axe, effect: -40))
    }
}

let game = Game(playerTurn: 1)


func player1Turn(){
    print ("C'est le tour du joueur 1")
    let player1 = game.createPlayer()
    game.createTeam()
}

func player2Turn(){
    print ("C'est au joueur 2")
    let player2 = game.createPlayer()
    game.createTeam()
}

player1Turn()
player2Turn()
