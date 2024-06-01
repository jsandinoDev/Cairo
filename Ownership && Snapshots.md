### Ownership

Cairo uses a linear type system. In such a type system, any value must be used and must only be used once. 

'Used' here means that the value is either destroyed or moved.

Destruction can happen in several ways:

- a variable goes out of scope.
- a struct is destructured.
- explicit destruction using destruct()

In Cairo, ownership applies to variables and not to values.

- Each variable in Cairo has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the variable is destroyed.


### Cases

- Moving values - pass thourght parameters
- Copy - create new
- Destruction. Compiler first call drop if it doesnt exist call destruct
- Clone to copy array

arr1.clone()


### References and snapshots

In Cairo, a snapshot is an immutable view of a value at a certain point in time.

```
fn main() {
    let mut arr1: Array<u128> = array![];
    let first_snapshot = @arr1; // Take a snapshot of `arr1` at this point in time
    arr1.append(1); // Mutate `arr1` by appending a value
    let first_length = calculate_length(
        first_snapshot
    ); // Calculate the length of the array when the snapshot was taken
    let second_length = calculate_length(@arr1); // Calculate the current length of the array
    println!("The length of the array when the snapshot was taken is {}", first_length);
    println!("The current length of the array is {}", second_length);
}

fn calculate_length(arr: @Array<u128>) -> usize {
    arr.len()
}
```


#### Desnap Operator
To convert a snapshot back into a regular variable, you can use the desnap operator *, which serves as the opposite of the @ operator.


```
#[derive(Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let rec = Rectangle { height: 3, width: 10 };
    let area = calculate_area(@rec);
    println!("Area: {}", area);
}

fn calculate_area(rec: @Rectangle) -> u64 {
    // As rec is a snapshot to a Rectangle, its fields are also snapshots of the fields types.
    // We need to transform the snapshots back into values using the desnap operator `*`.
    // This is only possible if the type is copyable, which is the case for u64.
    // Here, `*` is used for both multiplying the height and width and for desnapping the snapshots.
    *rec.height * *rec.width
}
```


### Mutable References
In Cairo, a parameter can be passed as mutable reference using the ref modifier.

Note: In Cairo, a parameter can only be passed as mutable reference using the ref modifier if the variable is declared as mutable with mut.


```
#[derive(Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let mut rec = Rectangle { height: 3, width: 10 };
    flip(ref rec);
    println!("height: {}, width: {}", rec.height, rec.width);
}

fn flip(ref rec: Rectangle) {
    let temp = rec.height;
    rec.height = rec.width;
    rec.width = temp;
}
```


```
The correct answer is:
fn give_and_take(ref arr: Array<u128>, n: u128) -> u128 {
    arr.append(n);
    arr.pop_front().unwrap_or(0)
}
fn main() {
    let mut arr1: Array<u128> = array![1,2,3];
    let elem = give_and_take(ref arr1, 4);
    println!("{}", elem);
}
```