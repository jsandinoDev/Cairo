# Match

match that allows you to compare a value against a series of patterns and then execute code based on which pattern matches.



```
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny => {
            println!("Lucky penny!");
            1
        },
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```

### Patterns That Bind to Values


Another useful feature of match arms is that they can bind to the parts of the values that match the pattern. This is how we can extract values out of enum variants.

```

#[derive(Drop, Debug)] // Debug so we can inspect the state in a minute
enum UsState {
    Alabama,
    Alaska,
}

#[derive(Drop)]
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter: UsState,
}

fn value_in_cents(coin: Coin) -> felt252 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        }
    }
}
```


### Matching with Option<T>


```
fn plus_one(x: Option<u8>) -> Option<u8> {
    match x {
        Option::Some(val) => Option::Some(val + 1),
        Option::None => Option::None,
    }
}

fn main() {
    let five: Option<u8> = Option::Some(5);
    let six: Option<u8> = plus_one(five);
    let none = plus_one(Option::None);
}
```


### Catch-all with the _ Placeholder

```
fn vending_machine_accept(coin: Coin) -> bool {
    match coin {
        Coin::Dime => true,
        _ => false,
    }
}
```

### Multiple Patterns with the | Operator

```
fn vending_machine_accept(coin: Coin) -> bool {
    match coin {
        Coin::Dime | Coin::Quarter => true,
        _ => false,
    }
}
```


### Matching tuples

```
#[derive(Drop)]
enum DayType {
    Week,
    Weekend,
    Holiday
}

fn vending_machine_accept(c: (DayType, Coin)) -> bool {
    match c {
        (DayType::Week, _) => true,
        (_, Coin::Dime) | (_, Coin::Quarter) => true,
        (_, _) => false,
    }
}
```

Writing (_, _) for the last arm of a tuple matching pattern might feel superfluous. Hence, we can use the _ => syntax if we want, for example, that our vending machine only accepts quarters on weekdays:

```
fn vending_week_machine(c: (DayType, Coin)) -> bool {
    match c {
        (DayType::Week, Coin::Quarter) => true,
        _ => false,
    }
}
```

### Matching felt252 and Integer Variables

You can also match felt252 and integer variables. This is useful when you want to match against a range of values. However, there are some restrictions:

- Only integers that fit into a single felt252 are supported (i.e. u256 is not supported).
- The first arm must be 0.
- Each arm must cover a sequential segment, contiguously with other arms.


Imagine we’re implementing a game where you roll a six-sided die to get a number between 0 and 5. If you have 0, 1 or 2 you win. If you have 3, you can roll again. For all other values you lose.

Here's a match that implements that logic:
```
fn roll(value: u8) {
    match value {
        0 | 1 | 2 => println!("you won!"),
        3 => println!("you can roll again!"),
        _ => println!("you lost...")
    }
}
```

## REVIEW QUESTIONS FOF THIS