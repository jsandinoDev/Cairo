



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