



## Variables


## Datatypes

#### Felt

default type 
```
let x: felt252 = 3;
```

#### Integer types

| Length  | Unsigned |
|---------|----------|
| 8-bit   | u8       |
| 16-bit  | u16      |
| 32-bit  | u32      |
| 64-bit  | u64      |
| 128-bit | u128     |
| 256-bit | u256     |
| 32-bit  | usize    |


#### Boolean
true or false

```
 let t = true;
```

#### String 

cairo uses the felt252 for string limit to 31 chaaracters

#### Byte Array

```
     let long_string: ByteArray = "this is a string which has more than 31 characters";

```

#### Type Casting

- try_into()


- into()

try_into returns an Option type, which you'll need to unwrap to access the new value.

```
fn main() {
    let my_felt252 = 10;
    // Since a felt252 might not fit in a u8, we need to unwrap the Option<T> type
    let my_u8: u8 = my_felt252.try_into().unwrap();
    let my_u16: u16 = my_u8.into();
    let my_u32: u32 = my_u16.into();
    let my_u64: u64 = my_u32.into();
    let my_u128: u128 = my_u64.into();
    // As a felt252 is smaller than a u256, we can use the into() method
    let my_u256: u256 = my_felt252.into();
    let my_usize: usize = my_felt252.try_into().unwrap();
    let my_other_felt252: felt252 = my_u8.into();
    let my_third_felt252: felt252 = my_u16.into();
}
```


```
//it ready
fn convert_to_felt(x: u8) -> felt252 {
    x.into()
}

//it ready
fn convert_felt_to_u8(x: felt252) -> u8 {
    //TODO return x as a u8.
    x.try_into().unwrap()
}

```

#### Tuple Type

Tuples have a fixed length


```
fn main() {
    let tup: (u32, u64, bool) = (10, 20, true);
}
```

To get the individual values out of a tuple, we can use pattern matching to destructure a tuple value, like this:

```
fn main() {
    let tup = (500, 6, true);

    let (x, y, z) = tup;

    if y == 6 {
        println!("y is 6!");
    }
}
```

We can also declare the tuple with value and types, and destructure it at the same time. For example:
```
fn main() {
    let (x, y): (felt252, felt252) = (2, 3);
}
```


#### Unit Type

A unit type is a type which has only one value ()


## Functions

```
fn multiplication(x: u64, y: u64) -> u64 {
    let res = x * y;
    res
}
```

## If/Else

```
    if number == 12 {
         println!("number is 12");
     }else if number - 2 == 1 {
         println!("number minus 2 is 1");
     } else {
         println!("number not found");
     }
```

### Complete Function with if 
```
fn calculate_price_of_apples(apples:u32) -> u32{
    let mut price = 0;
    if apples <= 40 {
        price = apples * 3;
    } else {
        price = apples * 2;
    }
    price
}
```

## Loops

Continue  -> tells the program to go to the next iteration


Return Valies -> break val;


```
fn test_loop() {
    let mut counter = 0;
    loop {
        if counter == 10 {
            break ();
        }
        if counter == 5 {
            //TODO return a value from the loop
            break counter;
        }
        counter += 1;
    };
}
```


## While

```
    let mut number = 3;

    while number != 0 {
        println!("{number}!");
        number -= 1;
    };
```

## Enums

```
#[derive(Drop, Copy)]
enum Message { 
    ChangeColor:(u8, u8, u8),
    Echo:felt252,
    Move:Point,
    Quit,
}

```

### Trait Implementations for Enums

Needs a process fn()

Can be like:
```
    fn process(self: Message) {
        match self {
            Message::Quit => { println!("quitting") },
            Message::Echo(value) => { println!("echoing {}", value) },
            Message::Move((x, y)) => { println!("moving from {} to {}", x, y) },
        }
    }
```


Or 

```
#[derive(Drop, Copy)]
struct State {
    color: (u8, u8, u8),
    position: Point,
    quit: bool,
}

trait StateTrait {
    fn change_color(ref self: State, new_color: (u8, u8, u8));
    fn quit(ref self: State);
    fn echo(ref self: State, s: felt252);
    fn move_position(ref self: State, p: Point);
    fn process(ref self: State, message: Message);
}

impl StateImpl of StateTrait {
    fn change_color(ref self: State, new_color: (u8, u8, u8)) {
        let State { color: _, position, quit, } = self;
        self = State { color: new_color, position: position, quit: quit, };
    }
    fn quit(ref self: State) {
        let State { color, position, quit: _, } = self;
        self = State { color: color, position: position, quit: true, };
    }

    fn echo(ref self: State, s: felt252) {
        println!("{}", s);
    }

    fn move_position(ref self: State, p: Point) {
        let State { color, position: _, quit, } = self;
        self = State { color: color, position: p, quit: quit, };
    }

    fn process(
        ref self: State, message: Message
    ) { // TODO: create a match expression to process the different message variants
        match message {
            Message::ChangeColor(color) => self.change_color(color),
            Message::Echo(s) => self.echo(s),
            Message::Move(p) => self.move_position(p),
            Message::Quit => self.quit(),
        }
    }
}

```


And then call it like

```
let mut state = State { quit: false, position: Point { x: 0, y: 0 }, color: (0, 0, 0), };
    state.process(Message::ChangeColor((255, 0, 255)));
    state.process(Message::Echo('hello world'));
    state.process(Message::Move(Point { x: 10, y: 15 }));
    state.process(Message::Quit);
```

****
## Options 

```
enum Option<T> {
    Some: T,
    None,
}
```

```
        if time_of_day < 22 {
            return Option::Some(5);
        } else if time_of_day == 22 {
            return Option::Some(0);
        } else {
            return Option::None;
        }
```

- is_some()  -> need to unwrap  "optional_target.unwrap()"
- is_none()

```
    if optional_target.is_some() {
        assert(optional_target.unwrap() == 'starklings', 'err1');
    } else {
        assert(optional_target.is_none(), 'err2');
    }


    if course.is_none() {
        println!("No grade");
    } else {
        println!("grade is {}", course.unwrap());
    }      
```


## Arrays 

```
    let mut arr = ArrayTrait::<u128>::new();
    let mut a = ArrayTrait::new();

    //add
    a.append(0);

    //remove
    a.pop_front().unwrap();

    // size
    a.len()

    // Empty
    a.is_empty()

    //at
    let first = *a.at(0);

    //get function returns an Option<Box<@T>>
    match a.get(index_to_access) {
        Option::Some(x) => {
            *x.unbox() 
        },
        Option::None => { panic!("out of bounds") }

```

### Array macro

Replace this
```
    let mut arr = ArrayTrait::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);
    arr.append(4);
    arr.append(5);

```
For: 
```
    let arr = array![1, 2, 3, 4, 5];
```

### Array with enums

```
#[derive(Copy, Drop)]
enum Data {
    Integer: u128,
    Felt: felt252,
    Tuple: (u32, u32),
}

fn main() {
    let mut messages: Array<Data> = array![];
    messages.append(Data::Integer(100));
    messages.append(Data::Felt('hello world'));
    messages.append(Data::Tuple((10, 30)));
}
```

### Span

- Span is a struct that represents a snapshot of an Array. 

```
    array.span();
```


## Structs


```
#[derive(Copy, Drop)]
//Copy: Allows copying an instance of Package.
//Drop: Allows defining a custom behavior for when an instance of Package is destroyed.
struct Package {
    sender_country: felt252,
    recipient_country: felt252,
    weight_in_grams: usize,
}
```


```
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}


    let mut user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };

    user1.email = "anotheremail@example.com";

    // OJO EL ..user1
    let user2 = User { email: "another@example.com", ..user1 };
```


## Traits

```
#[derive(Copy, Drop)]
struct Fish {
    noise: felt252,
    distance: u32,
}

#[derive(Copy, Drop)]
struct Dog {
    noise: felt252,
    distance: u32,
}

trait AnimalTrait<T> {
    fn new() -> T;
    fn make_noise(self: T) -> felt252;
    fn get_distance(self: T) -> u32;
}

trait FishTrait {
    fn swim(ref self: Fish) -> ();
}

trait DogTrait {
    fn walk(ref self: Dog) -> ();
}

impl AnimalFishImpl of AnimalTrait<Fish> {
    fn new() -> Fish {
        Fish { noise: 'blub', distance: 0 }
    }
    fn make_noise(self: Fish) -> felt252 {
        self.noise
    }
    fn get_distance(self: Fish) -> u32 {
        self.distance
    }
}

impl AnimalDogImpl of AnimalTrait<Dog> {
    fn new() -> Dog {
        Dog { noise: 'woof', distance: 0 }
    }
    fn make_noise(self: Dog) -> felt252 {
        self.noise
    }
    fn get_distance(self: Dog) -> u32 {
        self.distance
    }
}

// TODO: implement FishTrait for the type Fish

impl FishTraitImpl of FishTrait {
    fn swim(ref self: Fish) {
        self.distance += 1;
    }
}


// TODO: implement DogTrait for the type Dog
impl DogTraitImpl of DogTrait {
    fn walk(ref self: Dog) {
        self.distance += 1;
    }
}
```


## Dics

```
fn main() {
    let mut balances: Felt252Dict<u64> = Default::default();

    balances.insert('Alex', 100);
    balances.insert('Maria', 200);

    let alex_balance = balances.get('Alex');
    let maria_balance = balances.get('Maria');
}

```


Big Example

```
#[derive(Destruct)]
struct Team {
    level: Felt252Dict<usize>,
    players_count: usize,
}
```

```
#[generate_trait]
impl TeamImpl of TeamTrait {
    fn new() -> Team {
        Team {
            level: Default::default(),
            players_count: 0,
        }
    }

    fn get_level(ref self: Team, name: felt252) -> usize {
        self.level.get(name).try_into().unwrap_or(0)

    }

    fn add_player(ref self: Team, name: felt252, level: usize) {
        self.level.insert(name, level);
        self.players_count += 1;
    }

    fn level_up(ref self: Team, name: felt252) {
        // Intentar obtener el nivel actual del jugador
        let current_level = self.level.get(name);
    
        // Verificar si el jugador existe comprobando si el nivel actual no es 0 (nivel predeterminado)
        if current_level != 0 {
            // Incrementar el nivel del jugador en el diccionario
            self.level.insert(name, current_level + 1);
        }
    }

    fn players_count(self: @Team) -> usize {
        *self.players_count
    }
}
```

## Modules
