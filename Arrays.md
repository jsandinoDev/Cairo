# Arrays

### ArrayTrait

Collection of elements of the same type

- Arrays are, in fact, queues whose values can't be modified. 
- This has to do with the fact that once a memory slot is written to, it cannot be overwritten, but only read from it. 
- You can only append items to the end of an array and remove items from the front.


## Creating Array

```
fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);
    a.append(2);
}
```

You can pass the types
```
let mut arr = ArrayTrait::<u128>::new();
let mut arr:Array<u128> = ArrayTrait::new();

```

## Update
```
a.append(2);
```


## REmove
pop_front() method. This method returns an Option that can be unwrapped, containing the removed element, or Option::None if the array is empty.
```
fn main() {
    let mut a = ArrayTrait::new();
    a.append(10);
    a.append(1);
    a.append(2);

    let first_value = a.pop_front().unwrap();
    println!("The first value is {}", first_value);
}
```

## Reading elements
To access array elements, you can use get() or at() array methods that return different types. Using arr.at(index) is equivalent to using the subscripting operator arr[index].

### Get
The get function returns an Option<Box<@T>>, which means it returns an option to a Box type (Cairo's smart-pointer type) containing a snapshot to the element at the specified index if that element exists in the array. If the element doesn't exist, get returns None
```
fn main() -> u128 {
    let mut arr = ArrayTrait::<u128>::new();
    arr.append(100);
    let index_to_access =
        1; // Change this value to see different results, what would happen if the index doesn't exist?
    match arr.get(index_to_access) {
        Option::Some(x) => {
            *x
                .unbox() // Don't worry about * for now, if you are curious see Chapter 4.2 #desnap operator
        // It basically means "transform what get(idx) returned into a real value"
        },
        Option::None => { panic!("out of bounds") }
    }
}
```

### At
The at function, on the other hand, directly returns a snapshot to the element at the specified index using the unbox() operator to extract the value stored in a box. If the index is out of bounds, a panic error occurs. You should only use at when you want the program to panic if the provided index is out of the array's bounds, which can prevent unexpected behavior
```
fn main() {
    let mut a = ArrayTrait::new();
    a.append(0);
    a.append(1);

    let first = *a.at(0);
    let second = *a.at(1);
}

```
If you want to use the subscripting operator arr[index], you will need to explicitly define the type of the elements of the array, otherwise it will not compile. For example:

```
fn main() {
    let mut a: Array<felt252> = ArrayTrait::new();
    a.append(0);
    a.append(1);

    let first = a[0];
    let second = a[1];
}
```

In summary, use at when you want to panic on out-of-bounds access attempts, and use get when you prefer to handle such cases gracefully without panicking.


### Size

#### len()
The return value is of type usize.
#### is_empty()
s true if the array is empty and false otherwise.


### Array! Macro 

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



### Storing multiple types with Enums

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
- It is designed to provide safe and controlled access to the elements of an array without modifying the original array. 
- Span is particularly useful for ensuring data integrity and avoiding borrowing issues when passing arrays between functions or when performing read-only operations
```
    array.span();
```