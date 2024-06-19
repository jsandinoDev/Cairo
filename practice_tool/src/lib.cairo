#[derive(Copy, Drop)]
struct Sorcerer {
    attack: u8,
    health: u8,
    talent: Talent
}

// For Part 2...
#[derive(Copy, Drop)]
enum Talent {
    Talentless: (),
    Venomous: (),
    Swift: (),
    Guardian: ()
}

#[generate_trait]
impl SorcererImpl of SorcererTrait {

    fn new(attack: u8, health: u8) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: Talent::Talentless(())
        }
    }

    // For Part 2...
    fn with_talent(attack: u8, health: u8, talent: Talent) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: talent
        }
    }

    fn attack(self: @Sorcerer) -> u8 { *self.attack }
    fn health(self: @Sorcerer) -> u8 { *self.health }
    fn is_defeated(self: @Sorcerer) -> bool { *self.health == 0_u8 }

}


fn saturating_sub(a: u8, b: u8) -> u8 {
    if a < b {
        return 0;
    }
    a - b
}

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    // IMPLEMENT THIS FUNCTION
    println!("--------------- Running DUEL ---------------");

    let mut counter = 0;
    println!("Sourcer1 Initial healt is: {}", sorcerer1.health);
    println!("Sourcer2 Initial healt is: {}", sorcerer2.health);
    println!("Turn : {}", counter);
    println!("--- Start Loop ---");

    loop {
        if sorcerer1.health == 0 || sorcerer2.health == 0 {
            println!("--------------- Finish ---------------");
            break;
        } 
        sorcerer1.health = saturating_sub(sorcerer1.health, sorcerer2.attack);
        sorcerer2.health = saturating_sub(sorcerer2.health, sorcerer1.attack);
        counter += 1;
        println!("Turn : {}", counter);
        println!("Sourcer1 healt is: {}", sorcerer1.health);
        println!("Sourcer2 healt is: {}", sorcerer2.health);
        println!(" ********* ");

    }
}


fn main() {
    let mut sorcerer1 = SorcererTrait::new(2, 11);
    let mut sorcerer2 = SorcererTrait::new(4, 2);

    duel(ref sorcerer1, ref sorcerer2);
}
