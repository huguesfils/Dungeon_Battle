
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
            print ("Quel est votre nom ?")
            name = readLine()!
        }
        return Player(name: name)
    }
    
    func createTeam(){
        print("Veuillez choisir 3 personnages parmi la liste suivante")
        if let choice = readLine(){
            switch choice {
            case "1. Guerrier":
                team.append(Warrior.init())
            case "2. Mage":
                team.append(Wizard.init())
            case "3. Colosse":
                team.append(Colossus.init())
            case "4. Nain":
                team.append(Dwarf.init())
            default:
                print("Veuillez taper un chiffre compris entre 1 et 4")
            }
        }
        
    }
}

class Player {
    var name: String
    var team = [Hero]()
    init (name: String){
        self.name = name
    }
    
    func addHeroTeam(hero: Hero){
        if (team.count < 3) {
            team.append(hero)
        }
    }// ajouter le nom de chaque héro au demarrage + enum héro faire une fonction createPlayer (nom + team de 3 hero) ?
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
    
    func nameDeclaration(){
        print ("Quel est votre nom ?")
        if let characterName = readLine(){
            print("Bonjour \(characterName)")
        }
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
    init(){
        super.init(name: "", life: 100, weapon: Weapon(type: .Sword, effect: -10))
    }
}

class Wizard: Hero {
    // healing only, not himself
    init(){
        super.init(name: "", life: 70, weapon: Weapon(type: .Stick, effect: 5))
    }
}

class Colossus: Hero {
    // powerful, less damages, only fists
    init(){
        super.init(name: "", life: 150, weapon: Weapon(type: .Fists, effect: -20))
    }
}

class Dwarf: Hero {
    // big axe, power damage, low life
    init(){
        super.init(name: "", life: 50, weapon: Weapon(type: .Axe, effect: -40))
    }
}

let game = Game(playerTurn: 0)
let player1 = game.createPlayer()
print("Player 1 name is \(player1.name)")
let player2 = game.createPlayer()
print("Player 2 name is \(player2.name)")

