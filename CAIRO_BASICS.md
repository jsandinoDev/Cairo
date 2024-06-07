



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