// fn another_function() {
//     println!("Another function.");
// }

// fn main() {
//     println!("Hello, world!");
//     another_function();
// }


// -----------------

// fn main() {
//     another_function(5);
// }

// fn another_function(x: felt252) {
//     println!("The value of x is: {}", x);
// }

// -----------------

// fn main() {
//     print_labeled_measurement(5, "h");
// }

// fn print_labeled_measurement(value: u128, unit_label: ByteArray) {
//     println!("The measurement is: {value}{unit_label}");
// }

// -----------------

// fn foo(x: u8, y: u8) {}

// fn main() {
//     let first_arg = 3;
//     let second_arg = 4;
//     foo(x: first_arg, y: second_arg);
//     let x = 1;
//     let y = 2;
//     foo(:x, :y)
// }

// -----------------

fn five() -> u32 {
    5
}

fn main() {
    let x = five();
    println!("The value of x is: {}", x);
}

