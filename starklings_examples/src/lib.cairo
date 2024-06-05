#[derive(Drop, Copy)]
enum Message { // TODO: implement the message variant types based on their usage below
    ChangeColor: (u256, u8, u256),
    Echo: felt252,
    Move: Point,
    Quit,
}

#[derive(Drop, Copy)]
struct Point {
    x: u8,
    y: u8,
}