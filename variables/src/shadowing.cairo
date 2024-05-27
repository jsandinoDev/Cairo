fn main() {
    let x = 5;
    let x = x + 1;
    {
        let x = x * 2;
        println!("Inner scope x value is: {}", x);
    }
    println!("Outer scope x value is: {}", x);

    let x: u64 = 2;
    println!("The value of x is {} of type u64", x);
    let x: felt252 = x.into(); // converts x to a felt, type annotation is required.
    println!("The value of x is {} of type felt252", x);


    let initial_balance = 9;
    let initial_balance = initial_balance - 3;
    {
        let initial_balance = initial_balance * 2;
    }
    println!("Final balance is: {}", initial_balance);
}