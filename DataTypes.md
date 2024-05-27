

# Datatypes

## Scarlar Types
-  Felts 
-  Integers
-  Booleans
  

### Felt type

``` 
felt252
```
default type

Integer in the range 0≤x<P
P = very large prime number currently equal to 2^251+17⋅2^192+1

In Cairo, the result of xy
 is defined to always satisfy the equation xy⋅y==x

### Integer Types
his type declaration indicates the number of bits the programmer can use to store the integer.

Length	Unsigned
8-bit	u8
16-bit	u16
32-bit	u32
64-bit	u64
128-bit	u128
256-bit	u256
32-bit	usize

### Numeric Operations
``` 
fn main() {
    // addition
    let sum = 5_u128 + 10_u128;

    // subtraction
    let difference = 95_u128 - 4_u128;

    // multiplication
    let product = 4_u128 * 30_u128;

    // division
    let quotient = 56_u128 / 32_u128; //result is 1
    let quotient = 64_u128 / 32_u128; //result is 2

    // remainder
    let remainder = 43_u128 % 5_u128; // result is 3
}
```

### Boolean Type

```
fn main() {
    let t = true;

    let f: bool = false; // with explicit type annotation
}
```


### String Types

- short strings
- ByteArray using double quotes.

#### Short String
- 'a' is equivalent to 0x61
- 'b' is equivalent to 0x62
- 'c' is equivalent to 0x63
- 0x616263 is equivalent to 'abc'

Cairo uses the felt252 for short strings
As the felt252 is on 251 bits, a short string is limited to 31 characters (31 * 8 = 248 bits, which is the maximum multiple of 8 that fits in 251 bits).

```
    let my_first_char = 'C';
    let my_first_char_in_hex = 0x43;

    let my_first_string = 'Hello world';
    let my_first_string_in_hex = 0x48656C6C6F20776F726C64;

```


#### Byte Array String
You are not limited to 31 characters anymore.
```
    let long_string: ByteArray = "this is a string which has more than 31 characters";

```

### Type Casting
try_into()
into()

try_into returns an Option<T> type, which you'll need to unwrap to access the new value.

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

### Tuple Type

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

### Unit Type

A unit type is a type which has only one value ()