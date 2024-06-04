## Modules



"use" keyword


### Declare new modules

```
  // crate root file (src/lib.cairo)
  mod garden {
      // code defining the garden module goes here
  }
```

Routes
backyard::garden::vegetables::Asparagus

##### Private vs public
o make a module public, declare it with pub mod instead of mod


Modules can also hold definitions for other items, such as structs, enums, constants, traits, and functions.



### ENUMS
If we use pub before a struct definition, we make the struct public, but the struct’s fields will still be private. We can make each field public or not on a case-by-case basis.
In contrast, if we make an enum public, all of its variants are then public. We only need the pub before the enum keyword.



### use

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use restaurant::front_of_house::hosting::add_to_waitlist;

pub fn eat_at_restaurant() {
    add_to_waitlist();
}

```
Bringing the function’s parent module into scope with use means we have to specify the parent module when calling the function.  Specifying the parent module when calling the function makes it clear that the function isn’t locally defined while still minimizing repetition of the full path.


On the other hand, when bringing in structs, enums, traits, and other items with use, it’s idiomatic to specify the full path. 


```
use core::num::traits::BitSize;

fn main() {
    let u8_size: usize = BitSize::<u8>::bits();
    println!("A u8 variable has {} bits", u8_size)
}
```


### Providing New Names with the as Keyword


```
use core::array::ArrayTrait as Arr;

fn main() {
    let mut arr = Arr::new(); // ArrayTrait was renamed to Arr
    arr.append(1);
}
```

### Importing Multiple Items from the Same Module

General syntax :


use module::{item1, item2, item3};


```
// Assuming we have a module called `shapes` with the structures `Square`, `Circle`, and `Triangle`.
mod shapes {
    #[derive(Drop)]
    pub struct Square {
        pub side: u32
    }

    #[derive(Drop)]
    pub struct Circle {
        pub radius: u32
    }

    #[derive(Drop)]
    pub struct Triangle {
        pub base: u32,
        pub height: u32,
    }
}

// We can import the structures `Square`, `Circle`, and `Triangle` from the `shapes` module like this:
use shapes::{Square, Circle, Triangle};

// Now we can directly use `Square`, `Circle`, and `Triangle` in our code.
fn main() {
    let sq = Square { side: 5 };
    let cr = Circle { radius: 3 };
    let tr = Triangle { base: 5, height: 2 };
// ...
}
```


### Re-exporting Names in Module Files
When we bring a name into scope with the use keyword, the name available in the new scope can be imported as if it had been defined in that code’s scope. This technique is called re-exporting because we’re bringing an item into scope, but also making that item available for others to bring into their scope, with the pub keyword.

```
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

pub use restaurant::front_of_house::hosting;

fn eat_at_restaurant() {
    hosting::add_to_waitlist();
}

```

### Using External Packages in Cairo with Scarb

```
[dependencies]
alexandria_math = { git = "https://github.com/keep-starknet-strange/alexandria.git" }
```


## Separating Modules into Different Files

https://book.cairo-lang.org/ch07-05-separating-modules-into-different-files.html