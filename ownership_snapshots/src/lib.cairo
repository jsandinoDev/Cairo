// fn main() {
//     let mut arr1: Array<u128> = array![];
//     let first_snapshot = @arr1; // Take a snapshot of `arr1` at this point in time
//     arr1.append(1); // Mutate `arr1` by appending a value
//     let first_length = calculate_length(
//         first_snapshot
//     ); // Calculate the length of the array when the snapshot was taken
//     let second_length = calculate_length(@arr1); // Calculate the current length of the array
//     println!("The length of the array when the snapshot was taken is {}", first_length);
//     println!("The current length of the array is {}", second_length);
// }

// fn calculate_length(arr: @Array<u128>) -> usize {
//     arr.len()
// }

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