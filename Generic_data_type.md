### Generics


```
// Specify generic type T between the angulars
fn largest_list<T>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}

fn main() {
    let mut l1 = array![1, 2];
    let mut l2 = array![3, 4, 5];

    // There is no need to specify the concrete type of T because
    // it is inferred by the compiler
    let l3 = largest_list(l1, l2);
}
```

This will throw an error because there are no traits defined for dropping an array of a generic type

```
fn largest_list<T, impl TDrop: Drop<T>>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}

```


Constraints for Generic Types
```
// Given a list of T get the smallest one
// The PartialOrd trait implements comparison operations for T
fn smallest_element<T, impl TPartialOrd: PartialOrd<T>>(list: @Array<T>) -> T {
    // This represents the smallest element through the iteration
    // Notice that we use the desnap (*) operator
    let mut smallest = *list[0];

    // The index we will use to move through the list
    let mut index = 1;

    // Iterate through the whole list storing the smallest
    while index < list
        .len() {
            if *list[index] < smallest {
                smallest = *list[index];
            }
            index = index + 1;
        };

    smallest
}

fn main() {
    let list: Array<u8> = array![5, 3, 10];

    // We need to specify that we are passing a snapshot of `list` as an argument
    let s = smallest_element(@list);
    assert!(s == 3);
}
```
The smallest_element function uses a generic type T that implements the PartialOrd trait, takes a snapshot of an Array<T> as a parameter and returns a copy of the smallest element. Because the parameter is of type @Array<T>, we no longer need to drop it at the end of the execution and so we are not required to implement the Drop trait for T as well. Why does it not compile then?

When indexing on list, the value results in a snap of the indexed element, and unless PartialOrd is implemented for @T we need to desnap the element using *. The * operation requires a copy from @T to T, which means that T needs to implement the Copy trait. After copying an element of type @T to T, there are now variables with type T that need to be dropped, requiring T to implement the Drop trait as well. We must then add both Drop and Copy traits implementation for the function to be correct. After updating the smallest_element function the resulting code would be:
This will fail


```
fn smallest_element<T, impl TPartialOrd: PartialOrd<T>, impl TCopy: Copy<T>, impl TDrop: Drop<T>>(
    list: @Array<T>
) -> T {
    let mut smallest = *list[0];
    let mut index = 1;

    while index < list
        .len() {
            if *list[index] < smallest {
                smallest = *list[index];
            }
            index = index + 1;
        };

    smallest
}

```

### Anonymous Generic Implementation Parameter (+ Operator)

Until now, we have always specified a name for each implementation of the required generic trait: TPartialOrd for PartialOrd<T>, TDrop for Drop<T>, and TCopy for Copy<T>.


```
fn smallest_element<T, +PartialOrd<T>, +Copy<T>, +Drop<T>>(list: @Array<T>) -> T {

```


### Structs
```
#[derive(Drop)]
struct Wallet<T, U> {
    balance: T,
    address: U,
}

fn main() {
    let w = Wallet { balance: 3, address: 14 };
}
```

### Enums
```
enum Result<T, E> {
    Ok: T,
    Err: E,
}
```

### Generic methods
https://book.cairo-lang.org/ch08-01-generic-data-types.html#generic-methods