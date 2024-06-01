# Enums

Custom data type that consists of a fixed set of named values, called variants.  


```
#[derive(Drop)]
enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Drop)]
enum Direction {
    North: u128,
    East: u128,
    South: u128,
    West: u128,
}


    let direction = Direction::North(10);

```

### Enums Combined with Custom Types

```
#[derive(Drop)]
enum Message {
    Quit,
    Echo: felt252,
    Move: (u128, u128),
}

```

### Trait Implementations for Enums

```
trait Processing {
    fn process(self: Message);
}

impl ProcessingImpl of Processing {
    fn process(self: Message) {
        match self {
            Message::Quit => { println!("quitting") },
            Message::Echo(value) => { println!("echoing {}", value) },
            Message::Move((x, y)) => { println!("moving from {} to {}", x, y) },
        }
    }
}


    let msg: Message = Message::Quit;
    msg.process();

```


### The Option Enum and Its Advantages

The Option enum is a standard Cairo enum that represents the concept of an optional value. It has two variants: Some: T and None. Some: T indicates that there's a value of type T, while None represents the absence of a value.

```
enum Option<T> {
    Some: T,
    None,
}
```

The Option enum is helpful because it allows you to explicitly represent the possibility of a value being absent, making your code more expressive and easier to reason about. Using Option can also help prevent bugs caused by using uninitialized or unexpected null values.

```
fn find_value_recursive(mut arr: Span<felt252>, value: felt252, index: usize) -> Option<usize> {
    match arr.pop_front() {
        Option::Some(index_value) => { if (*index_value == value) {
            return Option::Some(index);
        } },
        Option::None => { return Option::None; },
    };

    find_value_recursive(arr, value, index + 1)
}

fn find_value_iterative(mut arr: Span<felt252>, value: felt252) -> Option<usize> {
    let mut result = Option::None;
    let mut index = 0;

    while let Option::Some(array_value) = arr
        .pop_front() {
            if (*array_value == value) {
                result = Option::Some(index);
                break;
            };

            index += 1;
        };

    result
}
```